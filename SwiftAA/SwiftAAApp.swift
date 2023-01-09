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
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var viewModel = SwiftAAViewModel()
    
    var body: some Scene {
        Window("SwiftAA", id: "swiftaa-window") {
            ContentView(dataHandler: viewModel.dataHandler, changed: $viewModel.changed)
                .applyVersionFrame(gameVersion: viewModel.settings.$gameVersion)
                .onAppear {
                    viewModel.onAppear()
                }
                .navigationTitle("SwiftAA")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        ToolbarRefreshView(visible: $viewModel.changed)
                    }
                    ToolbarItem(placement: .automatic) {
                        ToolbarPlayerHead()
                    }
                    ToolbarItem(placement: .automatic) {
                        ToolbarAAView(dataHandler: viewModel.dataHandler, changed: $viewModel.changed)
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
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("about-button".localized) {
                    NSApplication.shared.orderFrontStandardAboutPanel(
                        options: [
                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                string: "about-description".localized,
                                attributes: [
                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
                                        ofSize: NSFont.smallSystemFontSize)
                                ]
                            ),
                            NSApplication.AboutPanelOptionKey(
                                rawValue: "Copyright"
                            ): "about-copyright".localized
                        ]
                    )
                }
            }
            CommandGroup(after: .appInfo, addition: {
                Button("\("settings-updater-check".localized)...") {
                    viewModel.updater.checkForUpdates()
                }
            })
        }
        .windowResizability(.contentSize)
        
        Window("OverlayWindow", id: "overlay-window") {
            OverlayView(dataHandler: viewModel.dataHandler)
                .frame(minWidth: viewModel.settings.overlayLoaded ? (!viewModel.dataHandler.allAdvancements ? 400 : 825) : viewModel.settings.overlayWidth, maxWidth: viewModel.settings.overlayLoaded ? .infinity : viewModel.settings.overlayWidth, minHeight: 345, maxHeight: 345, alignment: .center)
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
                    Text("overlay-toggle", comment: "Button: shows/hides overlay")
                }
                .keyboardShortcut("o")
            })
            
            CommandGroup(replacing: .newItem, addition: {})
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
        
        Settings {
            SettingsView(dataHandler: viewModel.dataHandler, updater: viewModel.updater)
                .environmentObject(viewModel.settings)
        }
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
