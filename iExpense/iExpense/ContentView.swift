//
//  ContentView.swift
//  iExpense
//
//  Created by Omkar Malpure on 25/02/24.
//

import SwiftUI
import Observation


struct ExpenseItem:Identifiable,Encodable,Decodable {
    
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
    let currencyType : String
}




@Observable
class Expenses{
    
    //Very Very Important piece of code
    //Here when we add the data into the ExpenseItem Data Structure then we are using these dynamic variables in swift to directly convert that to json format and store it in our app so when user opens the app again he has his previous data stored in.
    var items = [ExpenseItem](){
        
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self,from:savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    
}

struct showCurrencyValue:View{
   
    var amount : Double
    var currency_code:String
    
    
    var body : some View {
        if (amount < 10){
            Text(amount,format: .currency(code: currency_code))
                .font(.subheadline)
                .foregroundStyle(.green)
                
        }
       else if (amount < 100){
                Text(amount , format:.currency(code: currency_code))
               .font(.headline)
               .foregroundStyle(.blue)
            }
                 
       else  {
                Text(amount ,format: .currency(code: currency_code))
               .font(.title)
               .foregroundStyle(.red)
            }
    }
}

struct ContentView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
////    @State private var user = User()
//    @State private var showingSheet = false
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    @State private var expenses = Expenses()
    
    @State private var showExpense = false
    
    
    var body : some View {
        NavigationStack{
            
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment:.leading){
                            Text("\(item.name)")
                                .font(.headline)
                            Text("\(item.type)")
                        }
                        Spacer()
                        showCurrencyValue(amount: item.amount, currency_code: item.currencyType)
                    }
                }.onDelete(perform: removeRows)
            }
            .navigationTitle("IExpense")
            .toolbar{
                Button("Add Item", systemImage: "plus"){
//                    let expense = ExpenseItem(name: "test", type: "personal", amount: 10)
//                    expenses.items.append(expense)
                    
                    showExpense = true
                }
            }
            .sheet(isPresented:$showExpense){
                AddView(expenses: expenses)
            }
        }
        
    }
        
func removeRows(at offsets : IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
}



#Preview {
    ContentView()
}
