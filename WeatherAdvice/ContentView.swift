//
//  ContentView.swift
//  WeatherAdvice
//
//  Created by Anora Zhu on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var temp = ""
    @State private var imageName = ""
    @State private var adviceMessage = ""
    @FocusState private var textFieldIsFocused: Bool
    
    var body: some View {
        VStack {
            Text("Weather Advice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.teal)
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding()
                .animation(.default, value: adviceMessage)
            
            Text(adviceMessage)
                .font(.largeTitle)
                .frame(height: 80)
                .minimumScaleFactor(0.5)
                .padding()
                .animation(.default, value: adviceMessage)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("What is the temp")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                TextField("", text: $temp)
                    .focused($textFieldIsFocused)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 65)
                    .overlay{
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                    }
                    .keyboardType(.numberPad)
                    .onChange(of: textFieldIsFocused, {
                        if textFieldIsFocused {
                            print("Tapped")
                            temp = ""
                            imageName = ""
                            adviceMessage = ""
                        }
                    })
                    
                Spacer()
            }
            .font(.title)
            .padding()
            
            Button("Get Advice") {
                textFieldIsFocused = false
                giveAdvice()
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .tint(.teal)
            .disabled(temp.isEmpty)
            .padding(.bottom)
            
        }
    }
    
    func giveAdvice() {
        guard let tempInt = Int(temp) else {
            adviceMessage = "Please enter a valid temperature."
            return
        }
        switch tempInt {
        case 76...:
            adviceMessage = "It's Hot"
            imageName = "hot"
        case 63..<76:
            adviceMessage = "Nice and mild!"
            imageName = "mild"
        case 45..<63:
            adviceMessage = "You're going to need a sweater."
            imageName = "cool"
        case 33..<45:
            adviceMessage = "You're going to need a coat!"
            imageName = "cold"
        default:
            adviceMessage = "Bundle up, it's freezing!"
            imageName = "freezing"
        }
            
    }
}

#Preview {
    ContentView()
}
