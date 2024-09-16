//
//  ContentView.swift
//  memory
//
//  Created by Matthew Kang on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    var flags: [String] = ["🇰🇷","🇪🇺","🇯🇵","🇺🇸","🇹🇭","🇫🇷","🇨🇮","🇩🇪","🇨🇦","🇦🇺"]
    let sports: [String] = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏓","🏸","🏒","🏹"]
    let animals: [String] = ["🐶","🐱","🐯","🦁","🦊","🐻","🐼","🐷","🐰","🐮"]
    
    var body: some View {
        @State var theme: [String] = animals
        @State var totalCards = theme + theme
        
        Text("Memory!")
            .imageScale(.large)
            .font(.system(.largeTitle, weight: .bold))
            .padding()
        
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 7) {
                ForEach(0..<20, id: \.self) {
                    index in
                    CardView(image: totalCards[index]).aspectRatio(39/50, contentMode: .fit)
                }
            }
        .padding()
        
        HStack(spacing: 60){
            Button(action: {
                theme.replaceSubrange(0...9, with: repeatElement(flags[0], count: 10))
            },
                label: {
                VStack{
                    Image(systemName: "flag.circle")
                        .font(.largeTitle)
                    Text("Flags")
                        .font(.system(size: 12, weight: .bold))
                }
            }
            )
            Button(action: {
                for i in 0...9 {
                    theme[i] = flags[i]  //how??
                    print("yo")
                }
            }, label: {
                VStack{
                    Image(systemName: "figure.run.circle")
                        .font(.largeTitle)
                    Text("Sports")
                        .font(.system(size: 12, weight: .bold))
                }
            })
            Button(action: {
                theme = animals
            }, label: {
                VStack {
                    Image(systemName: "dog.circle")
                        .font(.largeTitle)
                    Text("Animals")
                        .font(.system(size: 12, weight: .bold))
                }
                
            })
        }
    }
    
    
    
}





struct CardView: View {
    let image: String
    @State var face: Bool = true
    var body: some View {
        let surf = RoundedRectangle(cornerRadius: 10)
        ZStack {
            if (face == false) {
                surf.fill()
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
