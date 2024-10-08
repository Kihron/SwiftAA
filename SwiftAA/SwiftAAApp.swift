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
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    @ObservedObject private var viewModel = AppViewModel()
    
    var body: some Scene {
        Window("SwiftAA", id: "swiftaa-window") {
            ContentView()
                .applyVersionFrame()
                .navigationTitle("SwiftAA")
                .toolbar {
                    ToolbarItemGroup {
                        ToolbarRefreshView()
                        
                        HStack {
                            ToolbarPlayerHead()
                            ToolbarProgressView()
                        }
                        
                        ToolbarAlertView()
                    }
                }
                .removeFocusOnTap()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                .onAppear {
                    if OverlayManager.shared.overlayOpen {
                        openWindow(id: "overlay-window")
                    }
                }
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
                Button("\(L10n.Updater.Button.checkForUpdates)...") {
                    UpdateManager.shared.checkForUpdates()
                }
            })
        }
        .windowResizability(.contentSize)
        
        Window("Overlay Window", id: "overlay-window") {
            OverlayView()
                .applyOverlayFrame()
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
        
        Window(L10n.Settings.windowTitle, id: "settings-window") {
            SettingsView()
                .frame(minWidth: 700, maxWidth: 700, minHeight: 435, alignment: .center)
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
            OverlayManager.shared.closeOverlay()
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
