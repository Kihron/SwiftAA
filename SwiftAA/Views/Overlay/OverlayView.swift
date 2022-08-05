//
//  OverlayView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/3/22.
//

import SwiftUI

struct OverlayView: View {
    @ObservedObject var dataHandler: DataHandler
    @EnvironmentObject var settings: AppSettings
    
    @State var section = 0
    @State var totalSections = 0
    @State var criteriaSection = 0
    @State var criteriaTotalSections = 0
    
    @State var progress: CGFloat = 0.7
    private let animationTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: 10, alignment: .leading), count: Int(floor((screen.size.width - 40) / 26))), spacing: 20) {
                    ForEach(getCriteriaSection(criteriaSection, screen: screen), id: \.self) { criterion in
                            if (isAnimated(icon: criterion.icon)) {
                                QLImage(criterion.icon)
                                    .frame(width: 16, height: 16)
                            } else {
                                Image(criterion.icon)
                                    .frame(width: 16, height: 16)
                            }
                    }
                }
                .padding(.horizontal, 20)
                .frame(width: screen.size.width, height: 80, alignment: .top)
                .padding(.top, 10)
                
                Spacer()
                
                LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 74), spacing: 0), count: Int(floor(screen.size.width / 74))), spacing: 0) {
                        ForEach(getSection(section, screen: screen), id: \.self) { adv in
                            IndicatorView(indicator: .constant(adv))
                    }
                }
                .frame(width: screen.size.width)
                .padding(.trailing, 4)
                .padding(.bottom)
                
                ZStack {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 5)
                                .background(.gray)
                                .opacity(0.5)
                                .frame(width: max(0, screen.size.width * progress), height: 2)
                            
                            Spacer()
                        }
                    }
                    .frame(height: 10)
                    .padding(.top, -20)
                    
                    HStack {
                        Spacer()
                        
                        Text("\(dataHandler.map.values.flatMap({$0}).filter({$0.completed}).count)/\(dataHandler.map.values.compactMap({$0.count}).reduce(0, +))")
                            .font(.custom("Minecraft-Regular", size: 12))
                            .padding(.top, -20)
                            .padding(.trailing)
                    }
                }
            }
            .onReceive(animationTimer) { timer in
                withAnimation() {
                    self.progress -= 0.01
                }
                if self.progress <= 0.0 {
                    totalSections = totalSections(screen: screen) - 1
                    criteriaTotalSections = totalCriteriaSections(screen: screen) - 1
                    section = (section < totalSections) ? section + 1 : 0
                    criteriaSection = (criteriaSection < criteriaTotalSections) ? criteriaSection + 1 : 0
                    self.progress = 0.7
                }
            }
            .background(Color("overlay_green"))
        }
    }
    
    func getSection(_ section: Int, screen: GeometryProxy) -> [Advancement] {
        let values = dataHandler.map.values.flatMap({$0}).filter({!$0.completed})
        
        let maxOnScreen = Int(floor(screen.size.width / 74)) * 2
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalSections(screen: GeometryProxy) -> Int {
        return (dataHandler.map.values.flatMap({$0}).filter({!$0.completed}).count / Int((floor(screen.size.width / 74))) + 1) / 2
    }
    
    func getCriteriaSection(_ section: Int, screen: GeometryProxy) -> [Criterion] {
        let values = dataHandler.map.values.flatMap({$0}).filter({!$0.completed && !$0.criteria.isEmpty}).flatMap({$0.criteria}).filter{!$0.completed}
        
        let maxOnScreen = Int(floor((screen.size.width - 40) / 26)) * 3
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalCriteriaSections(screen: GeometryProxy) -> Int {
        let count = dataHandler.map.values.flatMap({$0}).filter({!$0.completed && !$0.criteria.isEmpty}).flatMap({$0.criteria}).filter{!$0.completed}.count
        let pages = (count / Int((floor((screen.size.width - 40) / 26))) + 1) / 3
        return (pages == 1 && count > Int((floor((screen.size.width - 40) / 26))) + 1) ? 2 : pages
    }
    
    func isAnimated(icon: String) -> Bool {
        return ["enchant_item", "enchanted_golden_apple", "summon_wither"].contains(icon)
    }
}

struct OverlayView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        OverlayView(dataHandler: dataHandler)
            .environmentObject(settings)
            .frame(width: 800, height: 300)
            .onAppear {
                _ = dataHandler.decode(file: "adventure")
            }
    }
}
