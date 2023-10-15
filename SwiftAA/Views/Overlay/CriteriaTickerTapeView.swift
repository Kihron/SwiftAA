//
//  CriteriaTickerTapeView.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

struct CriteriaTickerTapeView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var overlayManager = OverlayManager.shared
    @State private var buffer: RingBuffer<Criterion> = RingBuffer(size: 0)
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var xOffset: CGFloat = 0
    @State private var index = 0
    
    @State private var copy: [Criterion] = []
    
    var body: some View {
        GeometryReader { geometry in
            LazyHStack(spacing: 0) {
                if !dataManager.incompleteCriteria.isEmpty {
                    ForEach(buffer, id: \.?.id) { criterion in
                        if let criterion = criterion {
                            ZStack {
                                Group {
                                    if !isAnimated(icon: criterion.icon) {
                                        Image(criterion.icon)
                                            .resizable()
                                            .interpolation(.low)
                                            .frame(width: 24, height: 24)
                                            .drawingGroup()
                                    } else {
                                        QLImage(criterion.icon)
                                            .frame(width: 24, height: 24)
                                    }
                                }
                                .padding(8)
                                
                                if overlayManager.clarifyAmbigiousCriteria && dataManager.ambigiousCriteria.contains(criterion.icon) {
                                    if let adv = dataManager.getAdvancementForCriteria(criterion: criterion) {
                                        Image(adv.icon)
                                            .resizable()
                                            .interpolation(.none)
                                            .frame(width: 24, height: 24)
                                            .drawingGroup()
                                            .offset(x: -8, y: -5)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .offset(x: xOffset, y: 0)
            .onAppear {
                calculateBuffer(width: geometry.size.width)
                withAnimation(.spring(duration: 5)) {
                    xOffset -= 40
                }
            }
            .onChange(of: TrackerManager.shared.worldPath) { _ in
                resetBuffer(width: geometry.size.width)
            }
            .onChange(of: TrackerManager.shared.gameVersion) { _ in
                resetBuffer(width: geometry.size.width)
            }
            .onChange(of: TrackerManager.shared.trackingMode) { _ in
                resetBuffer(width: geometry.size.width)
            }
            .onChange(of: geometry.size.width) { value in
                calculateBuffer(width: value)
            }
            .onReceive(timer) { _ in
                if xOffset < -40 {
                    xOffset += 40
                    cycleIndicator()
                }
                withAnimation(.spring(duration: 5)) {
                    xOffset -= 40
                }
            }
        }
    }
    
    private func resetBuffer(width: CGFloat) {
        index = 0
        calculateBuffer(width: width)
    }
    
    private func calculateBuffer(width: CGFloat) {
        let count = getMaxOnScreen(width: width) + 3
        buffer = count == buffer.count ? buffer : RingBuffer<Criterion>(size: count)
        populateBuffer()
    }
    
    private func populateBuffer() {
        let current = dataManager.incompleteCriteria
        guard !current.isEmpty else { return }
        
        for idx in 0..<buffer.count {
            if idx < current.count - 1 {
                buffer.write(current[idx])
                index = (index + 1) % current.count
            }
        }
    }
    
    private func cycleIndicator() {
        let current = dataManager.incompleteCriteria
        guard !current.isEmpty else { return }
        
        if copy.count != current.count {
            let set = Set(current)
            let difference = copy.enumerated().filter({ $0.offset < index && !set.contains($0.element) }).count
            
            index -= difference
            copy = current
        }
        
        buffer.write(current[index % current.count])
        index = (index + 1) % current.count
    }
    
    private func getMaxOnScreen(width: CGFloat) -> Int {
        return Int(floor(width / 40))
    }
    
    private func isAnimated(icon: String) -> Bool {
        ["enchant_item", "enchanted_golden_apple", "summon_wither", "skulk_sensor"].contains(icon)
    }
}

#Preview {
    CriteriaTickerTapeView()
        .frame(width: 592, height: 150)
}
