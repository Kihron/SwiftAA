//
//  SwiftAAApp.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI

@main
struct SwiftAAApp: App {
    @Environment(\.openWindow) private var openWindow
    @ObservedObject private var coreDataManager = CoreDataManager.shared
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var viewModel = AppViewModel()
    
    var body: some Scene {
        Window("SwiftAA", id: "swiftaa-window") {
            ContentView()
                .applyVersionFrame()
                .onAppear {
                    viewModel.onAppear()
                }
                .navigationTitle("SwiftAA")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        ToolbarRefreshView(visible: $viewModel.advancementsUpdated)
                    }
                    ToolbarItem(placement: .automatic) {
                        HStack {
                            ToolbarPlayerHead()
                            
                            ToolbarProgressView()
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        if (!viewModel.error.isEmpty) {
                            ToolbarAlertView(error: $viewModel.error)
                        }
                    }
                }
                .removeFocusOnTap()
                .preferredColorScheme(.dark)
                .environmentObject(viewModel.settings)
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button(L10n.About.button) {
                    NSApplication.shared.orderFrontStandardAboutPanel(
                        options: [
                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                string: L10n.About.description,
                                attributes: [
                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
                                        ofSize: NSFont.smallSystemFontSize)
                                ]
                            ),
                            NSApplication.AboutPanelOptionKey(
                                rawValue: "Copyright"
                            ): L10n.About.copyright
                        ]
                    )
                }
            }
            CommandGroup(after: .appInfo, addition: {
                Button("\(L10n.Settings.Updater.check)...") {
                    UpdateManager.shared.checkForUpdates()
                }
            })
        }
        .windowResizability(.contentSize)
        
        Window("OverlayWindow", id: "overlay-window") {
            OverlayView(viewModel: .init(dataManager: viewModel.dataManager))
                .frame(minWidth: viewModel.settings.overlayLoaded ? (!viewModel.dataManager.allAdvancements ? 400 : 825) : viewModel.settings.overlayWidth, maxWidth: viewModel.settings.overlayLoaded ? .infinity : viewModel.settings.overlayWidth, minHeight: 345, maxHeight: 345, alignment: .center)
                .environmentObject(viewModel.settings)
                .onAppear {
                    Task {
                        let windows = NSApplication.shared.windows.filter({ window in
                            window.title == "OverlayWindow"
                        })
                        windows.first?.standardWindowButton(NSWindow.ButtonType.closeButton)!.isEnabled = false
                    }
                }
                .background(TransparentWindow())
        }.commands {
            CommandGroup(after: .sidebar, addition: {
                Button {
                    toggleOverlay()
                } label: {
                    Text(L10n.Overlay.toggle)
                }
                .keyboardShortcut("o")
            })
            
            CommandGroup(replacing: .newItem, addition: {})
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
        
        Window("Settings", id: "settings-window") {
            NewSettingsView()
                .frame(minWidth: 700, maxWidth: 700, minHeight: 300, alignment: .center)
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
        .commands {
            CommandGroup(replacing: .appSettings) {
                Button(action: { openWindow(id: "settings-window") }) {
                    Text("Settings...")
                }
                .keyboardShortcut(",", modifiers: .command)
            }
        }
        .windowResizability(.contentSize)
    }
    
    private func toggleOverlay() {
        let windows = NSApplication.shared.windows.filter({ window in
            window.title == "OverlayWindow"
        })
        
        if (!viewModel.settings.overlayLoaded) {
            viewModel.settings.overlayLoaded = true
            openWindow(id: "overlay-window")
        } else {
            guard let window = windows.first else {
                viewModel.settings.overlayLoaded = false
                return
            }
            viewModel.settings.overlayWidth = Double(window.frame.width)
            viewModel.settings.overlayLoaded = false
            windows.first!.close()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
    }
}
