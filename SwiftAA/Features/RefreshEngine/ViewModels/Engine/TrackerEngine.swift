//
//  TrackerEngine.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

@MainActor @Observable class TrackerEngine {
    var trackerLog: TrackerLog = .init()

    var progressManager: ProgressManager = .shared
    var playerManager: PlayerManager = .shared

    private let fileManager = FileManager.default
    private var activeWindows = [pid_t:(String, Version?)]()

    private var windowObserver: NSObjectProtocol? = nil
    private var savesObserver: DispatchSourceFileSystemObject? = nil
    private var worldObserver: DispatchSourceFileSystemObject? = nil
    private var logObserver: DispatchSourceFileSystemObject? = nil

    static let shared = TrackerEngine()

    private init() {
        setupWindowObserver()
    }

    private func setupWindowObserver() {
        windowObserver = NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didActivateApplicationNotification,
            object: nil,
            queue: .main
        ) { notification in
            if notification.userInfo?[NSWorkspace.applicationUserInfoKey] is NSRunningApplication {
                DispatchQueue.main.async {
                    self.refreshTracker()
                }
            }
        }
    }

    func refreshTracker() {
        let saves: String

        if Settings[\.tracker].trackingMode == .directory {
            saves = Settings[\.tracker].customSavesPath
        } else {
            if let info = getInstanceInfo(), !info.0.isEmpty {
                saves = info.0

                if (saves != trackerLog.lastWorkingDirectory) {
                    trackerLog.lastWorkingDirectory = saves
                }

                if let version = info.1, Settings[\.tracker].automaticVersionDetection {
                    if version != Settings[\.tracker].gameVersion {
                        Settings[\.tracker].gameVersion = version
                        return
                    }
                }
            } else {
                saves = trackerLog.lastWorkingDirectory
                if saves.isEmpty {
                    if trackerLog.updateErrorAlert(alert: .enterMinecraft) {
                        progressManager.clearProgressState()
                    }
                    return
                }
            }
        }

        setupWorldTracking(saves: saves)
    }

    private func setupWorldTracking(saves: String) {
        if fileManager.fileExists(atPath: saves) {
            let logFile = "\(saves)/../logs/latest.log"

            savesObserver = FileMonitor.observeDirectory(at: saves) {
                DispatchQueue.main.async {
                    self.updateWorldPath(saves: saves)
                    self.setupWorldObserver()
                }
            }

            logObserver = FileMonitor.observeFile(at: logFile) {
                DispatchQueue.main.async {
                    self.updateWorldPath(saves: saves)
                    self.setupWorldObserver()
                }
            }

            updateWorldPath(saves: saves)
            setupWorldObserver()
        } else {
            savesObserver?.cancel()
            logObserver?.cancel()
            worldObserver?.cancel()
            trackerLog.resetWorldPath()

            if saves.isEmpty {
                trackerLog.updateErrorAlert(alert: .noDirectory)
            } else {
                trackerLog.updateErrorAlert(alert: .directoryNotFound)
            }
        }
    }

    private func updateWorldPath(saves: String) {
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: saves).filter({ folder in
                folder != ".DS_Store"
            })

            guard !contents.isEmpty else {
                if trackerLog.updateErrorAlert(alert: .noWorlds) {
                    trackerLog.resetWorldPath()
                }
                return
            }

            var world = try contents.max { a, b in
                let date1 = try FileMonitor.getModifiedTime(of: "\(saves)/\(a)")
                let date2 = try FileMonitor.getModifiedTime(of: "\(saves)/\(b)")
                return date1?.compare(date2!) == ComparisonResult.orderedAscending
            }!

            world = "\(saves)/\(world)"
            trackerLog.worldPath = world
        } catch {
            print(error.localizedDescription)
        }
    }

    private func setupWorldObserver() {
        do {
            let worldPath = trackerLog.worldPath

            if (!["advancements", "stats"].allSatisfy(try fileManager.contentsOfDirectory(atPath: worldPath).contains)) {
                if trackerLog.updateErrorAlert(alert: .noFiles) {
                    progressManager.clearProgressState()
                }
                return
            }

            let files = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/advancements")
            let stats = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/stats")

            if (files.isEmpty || stats.isEmpty) {
                if trackerLog.updateErrorAlert(alert: .invalidDirectory) {
                    progressManager.clearProgressState()
                }
                return
            }

            let fileName = Settings[\.tracker].player.flatMap({ player in files.first(where: { $0.replacingOccurrences(of: "-", with: "") == "\(player.id).json" })}) ?? files[0]
            let advFilePath = "\(worldPath)/advancements/\(fileName)"

            worldObserver = FileMonitor.observeFile(at: advFilePath) {
                DispatchQueue.main.async {
                    self.readWorldFiles()
                }
            }

            readWorldFiles()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func readWorldFiles() {
        do {
            let worldPath = trackerLog.worldPath

            let files = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/advancements")
            let stats = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/stats")

            if (files.isEmpty || stats.isEmpty) {
                withAnimation {
                    if trackerLog.updateErrorAlert(alert: .invalidDirectory) {
                        progressManager.clearProgressState()
                    }
                }
                return
            }

            let fileName = Settings[\.tracker].player.flatMap({ player in files.first(where: { $0.replacingOccurrences(of: "-", with: "") == "\(player.id).json" })}) ?? files[0]
            let advFilePath = "\(worldPath)/advancements/\(fileName)"

            var advFileContents = try String(contentsOf: URL(fileURLWithPath: advFilePath))
            let advRange = NSRange(location: 0, length: advFileContents.count)
            advFileContents = Constants.dataVersionRegex.stringByReplacingMatches(in: advFileContents, range: advRange, withTemplate: "")

            let advancements = try JSONDecoder().decode([String:AdvancementData].self, from: Data(advFileContents.utf8))
            let statistics = try JSONDecoder().decode(StatisticData.self, from: Data(contentsOf: URL(fileURLWithPath: "\(worldPath)/stats/\(fileName)")))
            let uuid = String(fileName.dropLast(5))

            withAnimation {
                playerManager.updatePlayer(to: uuid)
                playerManager.updateAvailablePlayers(uuids: files.map({ ($0 as NSString).deletingPathExtension }))
                progressManager.updateProgressState(advancements: advancements, statistics: statistics.stats)
                trackerLog.updateErrorAlert(alert: .none)
                trackerLog.lastRefresh = Date.now
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func getInstanceInfo() -> (String, Version?)? {
        let workspace = NSWorkspace.shared
        let apps = workspace.runningApplications.filter { $0.activationPolicy == .regular }
        guard let currentApp = apps.first(where: { $0.isActive }) else { return nil }

        let pid = currentApp.processIdentifier
        if let info = activeWindows[pid] {
            return (info.0, info.1)
        }

        guard let arguments = Utilities.processArguments(pid: pid) else { return nil }
        let version = extractGameVersion(from: arguments)

        if let gameDirIndex = arguments.firstIndex(of: "--gameDir") {
            let info = "\(arguments[gameDirIndex + 1])/saves"
            activeWindows[pid] = (info, version)
            return (info, version)
        }

        if let nativesArg = arguments.first(where: { $0.starts(with: "-Djava.library.path=") }) {
            let basePath = nativesArg.dropFirst(20).replacingOccurrences(of: "natives", with: "")
            let possiblePaths = ["\(basePath).minecraft/saves", "\(basePath)/minecraft/saves"]

            if let validPath = possiblePaths.first(where: { fileManager.fileExists(atPath: $0) }) {
                activeWindows[pid] = (validPath, version)
                return (validPath, version)
            }
        }

        activeWindows[pid] = ("", nil)
        return nil
    }

    private func extractGameVersion(from processArguments: [String]) -> Version? {
        if let extractedVersion = extractGameVersionString(from: processArguments) {
            let baseVersion = extractedVersion.components(separatedBy: ".").prefix(2).joined(separator: ".")
            return Version(rawValue: extractedVersion) ?? Version(rawValue: baseVersion)
        }

        return nil
    }

    private func extractGameVersionString(from processArguments: [String]) -> String? {
        for (index, argument) in processArguments.enumerated() {
            if argument == "--version", index + 1 < processArguments.count {
                return processArguments[index + 1]
            } else if let match = Constants.versionRegex.firstMatch(in: argument, range: NSRange(argument.startIndex..., in: argument)), let range = Range(match.range(at: 1), in: argument) {
                return String(argument[range])
            }
        }

        return nil
    }
}
