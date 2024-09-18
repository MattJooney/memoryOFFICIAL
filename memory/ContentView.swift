//
//  ContentView.swift
//  memory
//
//  Created by Matthew Kang on 9/16/24.
//

import SwiftUI

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
        
        Text("Memory!")
            .imageScale(.large)
            .font(.system(.largeTitle, weight: .bold))
            .padding()
        
        if(gameStart == false) {
            Text("Pick a Theme!")
                .font(.system(.largeTitle, weight: .bold))
                .padding(.vertical, 265)
        }
        else{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing:7) {
                ForEach(0..<20, id: \.self) {
                    index in
                    CardView(image: totalCards[index]).aspectRatio(39/50, contentMode: .fit)
                }
                .padding()
            }
        }
        
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
