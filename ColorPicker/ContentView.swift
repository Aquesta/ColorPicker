//
//  ContentView.swift
//  ColorPicker
//
//  Created by Aquesta 's on 19.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var showAlert = false
    
    var rectangleHeight: CGFloat = 150
    var hstackWidth: CGFloat = 40
    var textWidth: CGFloat = 40
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(height: rectangleHeight)
                .foregroundColor(
                    setForegroundColorRectangle()
                )
                .padding()
            HStack {
                Text("\(lround(blueSliderValue))")
                    .frame(width: textWidth)
                Slider(value: $blueSliderValue, in: 0...255, step: 1)
                    .accentColor(.blue)
                TextField("Blue", value: $blueSliderValue, formatter: NumberFormatter(), onCommit: {
                    checkTextFieldValue()
                })
                    .styled()
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Wrong Format!"), message: Text("Enter number from 0 to 255"))
                    })
                    
            }.padding(.horizontal).frame(height: hstackWidth)
            HStack {
                Text("\(lround(redSliderValue))")
                    .frame(width: textWidth)
                Slider(value: $redSliderValue, in: 0...255, step: 1)
                    .accentColor(.red)
                TextField("Red", value: $redSliderValue, formatter: NumberFormatter(), onCommit: {
                    checkTextFieldValue()
                })
                    .styled()
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Wrong Format!"), message: Text("Enter number from 0 to 255"))
                })
            }.padding(.horizontal).frame(height: hstackWidth)
            HStack {
                Text("\(lround(greenSliderValue))")
                    .frame(width: textWidth)
                Slider(value: $greenSliderValue, in: 0...255, step: 1)
                    .accentColor(.green)
                TextField("Green", value: $greenSliderValue, formatter: NumberFormatter(), onCommit: {
                    checkTextFieldValue()
                })
                    .styled()
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Wrong Format!"), message: Text("Enter number from 0 to 255"))
                    })
            }.padding(.horizontal).frame(height: hstackWidth)
            Spacer()
        }
    }
    
    private func setForegroundColorRectangle() -> Color {
        return Color(
            red: redSliderValue/255,
            green: greenSliderValue/255,
            blue: blueSliderValue/255,
            opacity: 1
        )
    }
    
    private func checkTextFieldValue() {
        
        guard checkValue(redSliderValue) else {
            showAlert = true
            redSliderValue = 255
            return
        }
        
        guard checkValue(blueSliderValue) else {
            showAlert = true
            blueSliderValue = 255
            return
        }
        
        guard checkValue(greenSliderValue) else {
            showAlert = true
            blueSliderValue = 255
            return
        }
    }
    
    private func checkValue(_ value: Double) -> Bool {
        if value > 255 {
            return false
        } else if value < 0 {
            return false
        }
        return true
    }
}

extension View {
    func styled() -> some View {
        modifier(BorderedTextView())
    }
}

struct BorderedTextView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50.0)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.gray)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
