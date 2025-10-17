//
//  ContentView.swift
//  Dice
//
//  Created by Amire Abdikadyr on 17.10.2025.
//

import SwiftUI


struct ContentView: View {
    
    @State var number = 1
    
    var body: some View {
        VStack {
            Image("dice\(number)")
//                .onTapGesture {
//                    //click image action
//                    number = Int.random(in: 1...6)
//                }
        }
        
        //button
        Button(action:{
            // change dice number randomly
            number = Int.random(in: 1...6)
            
        }) {
            Text("Roll")
                .fontWeight(.bold)
                .font(.system(size: 32))
        }
    }
}

#Preview {
    ContentView()
}
