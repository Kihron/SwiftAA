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
                    closeOverlay()
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
            OverlayView()
                .applyOverlayFrame()
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
            SettingsView()
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
        if (!OverlayManager.shared.overlayOpen) {
            OverlayManager.shared.overlayOpen = true
            openWindow(id: "overlay-window")
        } else {
            closeOverlay()
        }
    }
    
    private func closeOverlay() {
        let windows = NSApplication.shared.windows.filter({ window in
            window.title == "OverlayWindow"
        })
        
        guard let _ = windows.first else {
            OverlayManager.shared.overlayOpen = false
            return
        }
        
        OverlayManager.shared.overlayOpen = false
        windows.first!.close()
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
