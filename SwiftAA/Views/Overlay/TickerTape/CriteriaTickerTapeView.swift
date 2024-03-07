//
//  CriteriaTickerTapeView.swift
//  SwiftAA
//
//  Created by Kihron on 2/27/24.
//

import SwiftUI

struct CriteriaTickerTapeView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var overlayManager = OverlayManager.shared
    @StateObject private var viewModel = CriteriaTickerTapeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CALayerHosting(layer: viewModel.containerLayer)
                    .frame(width: geometry.size.width, height: 40)
                    .onAppear {
                        viewModel.setupLayers(width: geometry.size.width)
                        viewModel.startAnimation(width: geometry.size.width)
                    }
                    .onChange(of: dataManager.lastModified) { _ in
                        viewModel.resetLayers(width: geometry.size.width, override: false)
                    }
                    .onChange(of: TrackerManager.shared.worldPath) { _ in
                        viewModel.resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: TrackerManager.shared.gameVersion) { _ in
                        viewModel.resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: TrackerManager.shared.trackingMode) { _ in
                        viewModel.resetLayers(width: geometry.size.width, override: false)
                    }
                    .onChange(of: overlayManager.clarifyAmbiguousCriteria) { _ in
                        viewModel.resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: overlayManager.invertScrollDirection) { _ in
                        viewModel.resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: overlayManager.tickerTapeSpeed) { _ in
                        viewModel.resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: geometry.size.width) { width in
                        viewModel.debounceResetLayers(width: width)
                    }
            }
        }
    }
}

#Preview {
    CriteriaTickerTapeView()
}
