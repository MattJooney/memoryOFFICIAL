//
//  ContentView.swift
//  memory
//
//  Created by Matthew Kang on 9/16/24.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct ContentView: View {
    let flags: [String] = ["🇰🇷","🇪🇺","🇯🇵","🇺🇸","🇹🇭","🇫🇷","🇨🇮","🇩🇪","🇨🇦","🇦🇺"]
    let sports: [String] = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏓","🏸","🏒","🏹"]
    let animals: [String] = ["🐶","🐱","🐯","🦁","🦊","🐻","🐼","🐷","🐰","🐮"]
    @State var theme = 
        ["🇰🇷","🇪🇺","🇯🇵","🇺🇸","🇹🇭","🇫🇷","🇨🇮","🇩🇪","🇨🇦","🇦🇺"]
    @State var gameStart = false
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        let totalCards: [String] = (theme + theme).shuffled()
        
        Group {
            if orientation.isPortrait {
                verticalGame(deck: totalCards)
            } else if orientation.isLandscape {
                horizontalGame(deck: totalCards)
            } else if orientation.isFlat {
                verticalGame(deck: totalCards)
            } else {
                verticalGame(deck: totalCards)
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        
    }
    
    @ViewBuilder
    func verticalGame(deck: [String]) -> some View {
        if(gameStart == false) {
            title
            titleScreen(size: 265)
            buttonRow
        }
        else{
            title
            deckLayout(cards: deck, pad: 8, gridSize: 90)
            buttonRow
        }
    }
    
    @ViewBuilder
    func horizontalGame(deck: [String]) -> some View {
        if(gameStart == false) {
            title
            titleScreen(size: 70)
            buttonRow
        }
        else{
            title
            deckLayout(cards: deck, pad: 0, gridSize: 65)
            buttonRow
        }
    }
    
    var title: some View{
        Text("Memory!")
            .imageScale(.large)
            .font(.system(.largeTitle, weight: .bold))
            .padding()
    }
    
    func titleScreen(size: CGFloat) -> some View {
        Text("Pick a Theme!")
            .font(.system(.largeTitle, weight: .bold))
            .padding(.vertical, size)
    }
    
    func deckLayout(cards: [String], pad: CGFloat, gridSize: CGFloat) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: gridSize))]) {
            ForEach(0..<20, id: \.self) {
                index in
                CardView(image: cards[index]).aspectRatio(39/50, contentMode: .fit)
            }
            .padding(pad)
        }
    }
    
    var buttonRow: some View {
        HStack(spacing: 60){
            themeChoose(topic: flags, pic: "flag.circle", label: "Flags")
            themeChoose(topic: sports, pic: "figure.run.circle", label: "Sports")
            themeChoose(topic: animals, pic: "dog.circle", label: "Animals")
        }
    }
    
    func themeChoose
    (topic: [String], pic: String, label: String) -> some View {
        Button(action: {
            gameStart = true
                theme = topic
        }, label: {
            VStack {
                Image(systemName: pic)
                    .font(.largeTitle)
                Text(label)
                    .font(.system(size: 12, weight: .bold))
            }
            
        })
    }
    
}


struct CardView: View {
    let image: String
    @State var face: Bool = false
    var body: some View {
        let surf = RoundedRectangle(cornerRadius: 10)
        ZStack {
            if (face == false) {
                surf.foregroundColor(.red).opacity(0.7)
                surf.strokeBorder(lineWidth: 2)
            }
            else{
                Group {
                    surf.foregroundColor(.white)
                    surf.strokeBorder(lineWidth: 2)
                    Text(image).imageScale(.large).font(.largeTitle)
                }
            }
            
        }
        .onTapGesture {
            face.toggle()
        }
    }
}



#Preview {
    ContentView()
}
