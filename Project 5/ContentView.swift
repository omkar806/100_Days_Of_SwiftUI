//
//  ContentView.swift
//  BetterRest
//
//  Created by Omkar Malpure on 24/12/23.
//
//To fix range in this stepper we have in : 1...100 attribute
//and for now if we want number to increment by 2 then we have step attribute

    

//Now learning date Picker
import SwiftUI
import CoreML
struct ContentView: View {
    
    @State private var wakeup = defaultWaketime
    @State private var sleepAmount = 4.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var showText = true
    
    static var defaultWaketime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        
        NavigationStack{
            Form {
                
                VStack(alignment: .leading, spacing: 0){
                    Text("When do You wanna to WakeUp ?")
                        .font(.headline)
                    
                    DatePicker("",selection: $wakeup,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Desired Amount of Sleep ?")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours" , value:$sleepAmount , in: 4...12,step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0){
                    
                    
                        
                    
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)"  , value:$coffeeAmount , in:1...20)
                    
                    Picker("Your Coffee Intake ?", selection: $coffeeAmount){
                        
                        ForEach(1..<21){ cup in
                            
            
                            Text("^[\(cup) cup](inflect: true)")
                        }
                    }
                    .font(.headline)
                    .pickerStyle(.navigationLink)
                    
                  
                }
                
                VStackLayout(alignment: .leading, spacing: 0){
                    if showText{
                        Text("Your Result : ")
                            .font(.headline)
                        Text("\(alertTitle) \(alertMessage)")
                            .font(.headline)
                        
                    }
                }
                
                
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button{
                    calculate()
                }
            label:{
                Text("Calculate")
            }
            }
            .alert(alertTitle,isPresented: $showAlert){
                Button("OK"){}
            }
        message: {
            Text(alertMessage)
        }
        }
    }
    
    func calculate(){
        print("Button Clicked !!")
        
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour , .minute], from: wakeup)
            
            let hour = (components.hour ?? 0)*60*60
            let minute = (components.minute ?? 0)*60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeup - prediction.actualSleep
            alertTitle = "Your Bed Time is !!"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }
        catch{
            alertTitle="Error"
            alertMessage = "Sorry , there was a problem calculating your BedTime !!"
        }
//        showAlert = true
        showText=true
    }
}

#Preview {
    ContentView()
}
