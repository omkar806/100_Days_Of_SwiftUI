//
//  ContentView.swift
//  WeSplit
//
//  Created by Omkar Malpure on 01/12/23.
//

import SwiftUI

struct ContentView: View {
    //private specifies that this is only for this particular view
//    let students = ["Omkar" , "Siddharth" , "Anuj" , "Om"]
//    @State private var selectedStudent = "Omkar"
//    @State private var tapCount = 0
//    @State private var name = ""
    @State private var checkAmount = 0.0
    @State private var noOfPeople = 2
    
    @State private var tipPercentage = 0
    @FocusState private var isCheck : Bool
    
    @State private var totalbillAmount : Double = 0.0
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson : Double {
        
        let peopleCount = Double(noOfPeople) + 2
        
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let totalAmount = checkAmount + tipValue
        
        let amountPerperson = totalAmount / peopleCount
        
        
        return amountPerperson
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("" , value: $checkAmount ,format:  .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isCheck)
                    
                    Picker("Number Of People : " , selection: $noOfPeople){
                        
                        //                    ForEach(tipPercentage , id : \.self){
                        //
                        //                    }
                        
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                        //So here $0 represents the index and not the value from 2 to 100
                        // So 2 -> index 0
                        // 3 -> index 1
                        // 4 -> index 2 and $0 represents index value hence we can see 2
                        
                    }
                    .pickerStyle(.navigationLink)
                    
//                    Text("No of People Picked : \(noOfPeople)")
                }
                //this is called as section header we can also add a footer to it
                Section("How much do you want to tip ?"){
                    Picker("Tip  Percentage :" , selection: $tipPercentage){
                        //in foreach when we are traversing through any list or something  tipPercentages is a list see above
                        ForEach(0..<101){
                            Text($0,format : .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Bill Amount"){
                    let personCount = Double(noOfPeople) + 2
                    
                    let tipSelection = Double(tipPercentage)
                    let tipValue = checkAmount / 100 * tipSelection
                    let totalAmount = checkAmount + tipValue
                    Text("Total Amount : \(totalAmount)")
                }
                
                Section("Amount Per Person"){
                    Text(totalPerPerson , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
               
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isCheck {
                    Button("Done"){
                        isCheck = false
                    }
                }
            }
        }
        
        
        
        
        
        
        
//        NavigationStack{
//            Form{
//                Section{
//                    TextField("Enter your name " , text: $name)
//                    Text("My Name is \(name)")
//                }
//                Section{
//                    Button("Tap Count : \(tapCount)") {
//                        tapCount += 1
//                    }
//                }
//
//                Section{
//                    Picker("Pick the Students for the Internship :" , selection: $selectedStudent){
//                        ForEach(students , id : \.self){
//                            Text($0)
//                        }
//                    }
//                    Text("The Selected Student for the Internship \(selectedStudent)")
//                }
//            }
//
//            }
        }
        //How to create button and specify action into those buttons
        //Whatever you want button to display type inside the paranthesis of the button
       
        
        //Now lets see some TextFields
        //first of sll text field requires to to read and write the text simultaneously .
       
        
        
        
    }
   


#Preview {
    ContentView()
}
