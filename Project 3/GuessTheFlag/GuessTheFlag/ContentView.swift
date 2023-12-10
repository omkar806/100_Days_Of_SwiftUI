//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Omkar Malpure on 07/12/23.
//

import SwiftUI

struct ContentView: View {
//    @State private var showalert = false
    @State private var trackScore = 0
    @State private var countries = ["Estonia" , "France" , "Germany" , "Ireland" , "Italy" , "Nigeria" , "Poland" , "Spain" , "UK" , "Ukraine" , "US","Monaco"].shuffled()
    @State private var userTapCount = 0
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showScore = false
    
    @State private var scoreTitle = ""
    @State private var userSelectedAnswer  = Int()
    @State private var tapCountBool = false
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue , .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing : 30){
                
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.headline.weight(.heavy))
                        
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                    
                    
                }
                
                ForEach(0..<3){
                    number in
                    
                    Button{
                        print("button clicked")
                        userSelectedAnswer = number
                        userTapCount+=1
                        Flagtapped(number,userTapCount)
                    }label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 10)
                    }
                }
                Text("Your Total Score is : \(trackScore)")
                    .foregroundStyle(.white)
                    .font(.callout.weight(.heavy))
            }
            
            .alert(scoreTitle, isPresented: $showScore){
                Button("Continue" , action: askQuestion)
            }message: {
               
                    if userSelectedAnswer != correctAnswer{
                        Text("That is the Flag of \(countries[userSelectedAnswer]) \n Correct Answer is option \(correctAnswer+1)")
                        
            

//                        Text("Correct Answer is option \(correctAnswer+1)")
                    }
                
             
//                Text("Your Score is \(trackScore)")
            }
        }
        .alert("You have completed the Game by Finishing 8 Questions" , isPresented: $tapCountBool){
                           Button("Restart Game" , action: ResetGame)
                       }message: {
                           Text("Your Final Score : \(trackScore)")
                       }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //        VStack {
        //            Button("Button 1",role: .destructive , action: peformAction)
        //                .buttonStyle(.borderedProminent).tint(.red)
        //
        //
        //            //Create a Button on your own
        //
        //            Button{
        //                //Perform an action here
        //
        //                print("custom button")
        //            }label: {
        //                Text("This is Omkar")
        //                .padding()
        //                .foregroundColor(.white)
        //                .background(.blue)
        //            }
        //
        //            //Custom button finished
        //
        //
        //
        //            //images
        //
        ////            Image("summer")
        //
        //            Image(systemName: "pencil.circle")
        //                .foregroundColor(.red)
        //                .font(.largeTitle)
        //
        //
        //            //1st way for button with image and text
        //
        //            Button{
        //                print("image button with text")
        //            }label: {
        //                HStack{
        //
        //                    Image(systemName: "pencil.circle")
        //
        //                }
        //            }
        //            //The most customizable way for a button we can have the image and text any where on left or right
        //            //second way
        //
        //            Button("Edit2", systemImage: "pencil.circle"){
        //                print("image button with text second approach")
        //            }
        //
        //            Button{
        //                print("image button with text third approach blah blah")
        //            }
        //        label:{
        //            Label("Edit3" , systemImage: "pencil.and.outline")
        //                .imageScale(.small)
        //
        //        }
        //
        //
        //            Button("Show Alert"){
        //                showalert = true
        //            }
        //            .alert("important message" , isPresented: $showalert){
        //                Button("OK"){}
        //            }
        //
        //        }
        //    }
        //    func peformAction(){
        //        print("Action performed")
        //    }
    }
    func Flagtapped(_ number : Int , _ tapCount : Int){
        if (number == correctAnswer){
            scoreTitle = "Correct"
            trackScore += 1
        }
        else{
            scoreTitle = "Wrong"
            trackScore -= 1
        }
        showScore = true
        print(tapCount)
        if(tapCount > 8){
            tapCountBool = true
        }
        
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func ResetGame (){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        trackScore = 0
    }
}

#Preview {
    ContentView()
}
