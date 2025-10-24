//
//  ContentView.swift
//  Alash
//
//  Created by Amire Abdikadyr on 24.10.2025.
//
import SwiftUI

struct ContentView: View {
    @State private var currentIndex = 0
    
    let imageNames = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    
    var body: some View {
        ZStack {
          
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("Alash Orda")
                    
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                    .foregroundColor(.white)
                
                Spacer()
                
               
                Image(imageNames[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 350)
                    .padding(.horizontal, 15)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                
                Spacer()
                
                
                Button(action: {
                    
                    currentIndex = (currentIndex + 1) % imageNames.count
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
