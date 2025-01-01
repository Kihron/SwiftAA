//
//  FileMonitor.swift
//  SwiftAA
//
//  Created by Kihron on 12/31/24.
//

import SwiftUI

final class FileMonitor: Sendable {
    static func observeFile(at path: String, debounceDelay: TimeInterval = 0.1, onChange: @escaping () -> Void) -> DispatchSourceFileSystemObject? {
        let fileDescriptor = open(path, O_EVTONLY)

        guard fileDescriptor != -1 else {
            return nil
        }

        let queue = DispatchQueue.global(qos: .default)
        let source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fileDescriptor, eventMask: .write, queue: queue)

        var workItem: DispatchWorkItem?

        source.setEventHandler {
            workItem?.cancel()
            workItem = DispatchWorkItem {
                onChange()
            }

            if let workItem = workItem {
                queue.asyncAfter(deadline: .now() + debounceDelay, execute: workItem)
            }
        }

        source.setCancelHandler {
            close(fileDescriptor)
        }

        source.resume()
        return source
    }

    static func observeDirectory(at path: String, debounceDelay: TimeInterval = 0.1, onChange: @escaping () -> Void) -> DispatchSourceFileSystemObject? {
        let fileDescriptor = open(path, O_EVTONLY)

        guard fileDescriptor != -1 else {
            return nil
        }

        let queue = DispatchQueue.global(qos: .default)

        let eventMask: DispatchSource.FileSystemEvent = [.write, .delete, .rename, .attrib]
        let source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: eventMask,
            queue: queue
        )

        var workItem: DispatchWorkItem?

        source.setEventHandler {
            workItem?.cancel()
            workItem = DispatchWorkItem {
                onChange()
            }

            if let workItem = workItem {
                queue.asyncAfter(deadline: .now() + debounceDelay, execute: workItem)
            }
        }

        source.setCancelHandler {
            close(fileDescriptor)
        }

        source.resume()
        return source
    }

    static func getModifiedTime(of filePath: String) throws -> Date? {
        return try FileManager.default.attributesOfItem(atPath: filePath)[FileAttributeKey.modificationDate] as? Date
    }
}
