//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Omkar Malpure on 18/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var compPick = ["Rock" , "Paper" , "Scissors"].shuffled()
    
    
    @State private var compInt = Int.random(in: 0...2)
    
    @State private var winOrLoss = ["Win" , "Loose"]
    @State private var userWinLoss = ""
    @State private var userPickvar = ""
    
    @State private var userScore = 0
    
    @State private var showUserValue = ""
    
    @State private var AlertBool = false
    
   @State private var questionCount = 0
    
@State private var gameEnd = false
    
    
    var body: some View {
        
        
        
        VStack{
            
            Image(compPick[compInt])
                .imageScale(.small)
                .clipShape(.capsule)
            Form{
                
                Section("Prompt"){
                    Picker("Win or Loose" , selection: $userWinLoss){
                        ForEach(winOrLoss , id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                
                
                
                
            }.frame(width: .infinity ,height: 100)
            
            
            
            VStack{
      
                ForEach(0..<3){ number in
                    if userWinLoss == "Win"{
                        if number != compInt {
                            Button{
                                //                                    print(compInt)
                                print("Button Clicked")
                                questionCount+=1
                                playingGame(userWinLoss , compPick[number])
                                print()
                                print()
                                
                                
                            }label: {
                                Text(compPick[number])
                            }
                        }
                    }
                    
                    
                    else if (userWinLoss == "Loose"){
                        
                        
                        if number != compInt {
                            Button{
                                
                                playingGame(userWinLoss , compPick[number])
                                
                            }label: {
                                Text(compPick[number])
                            }
                        }
                        
                        
                        
                    }
                    
                    
                }
                
            }.alert("Checking Your Answer : \(showUserValue)", isPresented: $AlertBool){
                Button("Continue" , action : Alertbutton)
            }
            
            
            
            
            HStack{
                Text("Your Score is : \(userScore)")
            }
            
            
            
        }.alert("Game Completed , Want to Play Again !!",isPresented: $gameEnd){
            Button("Reset",action: GameCompleted)
        }
        
        
    }
    
    func playingGame (_ promptvalue : String , _ userPickvalue : String ) {
        print("Computer Value")
        print(compPick[compInt])
        print("UserValue")
        print(userPickvalue)
        if promptvalue == "Win"{
            if ( (compPick[compInt] == "Rock" && userPickvalue == "Paper") || (compPick[compInt] == "Paper" && userPickvalue == "Scissors") || (compPick[compInt] == "Scissors" && userPickvalue == "Rock")  ) {
                print()
                print("Entered in Win true")
                showUserValue = "Correct Answer !!"
                userScore += 1
                
            }
            
            else{
                print("Entered in Win false")

                showUserValue = "Incorrect Answer"
            }
            
            
           
            AlertBool = true
        }
        
        else {
            
            if ( (compPick[compInt] == "Rock" && userPickvalue != "Paper") || (compPick[compInt] == "Paper" && userPickvalue != "Scissors") || (compPick[compInt] == "Scissors" && userPickvalue != "Rock")  ) {
                showUserValue = "Correct Answer !!"
                userScore += 1
                
            }
            else{
                showUserValue = "Incorrect Answer !"
                
            }
            
            AlertBool = true
        }
        
        if (questionCount >= 8){
            gameEnd = true
        }
    print(questionCount)
    }
    
    
    func Alertbutton () {
        
        showUserValue=""
        userWinLoss=""
        AlertBool = false
        compPick.shuffle()
        compInt = Int.random(in: 0...2)
    }
    
    //Resetting the game
    func GameCompleted(){
        userScore = 0
        compPick.shuffle()
        compInt = Int.random(in: 0...2)
        gameEnd = false
        showUserValue=""
        userWinLoss=""
        questionCount=0
        AlertBool = false

        
    }
}

#Preview {
    ContentView()
}
