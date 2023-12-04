//
//  ContentView.swift
//  ConvertUnit
//
//  Created by Omkar Malpure on 04/12/23.
//

import SwiftUI

struct ContentView: View {
    
    let Temperatures = ["celcius" , "fahrenheit" , "kelvin"]
    
    @State private var inputTemp = "celcius"
    
    @State private var outputTemp = "fahrenheit"
    

    
    
    @State private var inputValue : Double = 0.0
    
    var outputValue : Double {
        var celciusValue = Double()

        if inputTemp == "fahrenheit"{
            celciusValue = ((inputValue - 32)*5) / 9
        }
        else if (inputTemp == "kelvin"){
            celciusValue = inputValue - 273.15
        }
        else {
            celciusValue = inputValue
        }
        
        if (outputTemp == "fahrenheit"){
            return (celciusValue*9)/5 + 32
        }
       
        else if(outputTemp == "kelvin"){
            return celciusValue + 273.15
        }
       return celciusValue
   }

    
    
    var body: some View {
        
        NavigationStack{
            Form{
                Section("Input Unit"){
                    
                    Picker("Select Input Unit" , selection: $inputTemp){
                        ForEach(Temperatures , id : \.self){
                            Text($0)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                
                
                Section("Output Unit"){
                    Picker("Select Input Unit" , selection: $outputTemp){
                        ForEach(Temperatures , id : \.self){
                            Text($0)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Enter your value"){
                    TextField("Enter your Value" , value : $inputValue , format : .number)
                        .keyboardType(.numberPad)
                        
                }
                
                
                Section("Converted Value"){
                    
                    Text(outputValue , format : .number)
                    
                    
                }
                
            }
            .navigationTitle("Temperature Conversion")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
        
    
    }
}

#Preview {
    ContentView()
}
