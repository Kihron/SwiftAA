//
//  IndicatorTickerTapeView.swift
//  SwiftAA
//
//  Created by Kihron on 9/7/23.
//

import SwiftUI

struct IndicatorTickerTapeView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @State private var buffer: RingBuffer<Indicator> = RingBuffer(size: 0)
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var xOffset: CGFloat = 0
    @State private var index = 0
    
    @State private var copy: [Advancement] = []
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(buffer, id: \.?.id) { indicator in
                    if let indicator = indicator {
                        if !isAnimated(icon: indicator.icon) {
                            IndicatorView(indicator: .constant(indicator), isOverlay: true)
                                .drawingGroup()
                        } else {
                            IndicatorView(indicator: .constant(indicator), isOverlay: true)
                        }
                    }
                }
            }
            .offset(x: xOffset, y: 0)
            .onAppear {
                calculateBuffer(width: geometry.size.width)
                withAnimation(.spring(duration: 5)) {
                    xOffset -= 74
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
                if xOffset < -74 {
                    xOffset += 74
                    cycleIndicator()
                }
                withAnimation(.spring(duration: 5)) {
                    xOffset -= 74
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
        buffer = count == buffer.count ? buffer : RingBuffer<Indicator>(size: count)
        populateBuffer()
    }
    
    private func populateBuffer() {
        let current = dataManager.incompleteAdvancements
        guard !current.isEmpty else { return }
        
        index = 0
        for idx in 0..<buffer.count {
            if idx < current.count - 1 {
                buffer.write(current[index])
                index = (index + 1) % current.count
            }
        }
    }
    
    private func cycleIndicator() {
        let current = dataManager.incompleteAdvancements
        guard !current.isEmpty else { return }
        
        if copy.count != current.count {
            let set = Set(current)
            let difference = copy.enumerated().filter({ $0.offset < index && !set.contains($0.element) }).count
            
            index -= difference
            copy = current
        }
        
        buffer.write(current[index])
        index = (index + 1) % current.count
    }
    
    private func getMaxOnScreen(width: CGFloat) -> Int {
        return Int(floor(width / 74))
    }
    
    private func isAnimated(icon: String) -> Bool {
        ["enchant_item", "enchanted_golden_apple", "summon_wither", "skulk_sensor"].contains(icon)
    }
}

#Preview {
    IndicatorTickerTapeView()
        .frame(width: 592, height: 150)
}
