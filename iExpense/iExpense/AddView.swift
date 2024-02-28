//
//  AddView.swift
//  iExpense
//
//  Created by Omkar Malpure on 25/02/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    var expenses : Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency_selection = "USD"
    let types = ["Personal" , "Buisness"]
    let currencies = ["USD" , "EUR","GBP","INR","TRY" , "NOK" , "SEK" ]
    var body: some View {
        NavigationStack{
            Form{
                
                //Enter item name
              
                    TextField("Name" , text: $name)
                
                
                //Select type
                
                    
                    Picker("Tyoe", selection: $type){
                        ForEach(types , id:\.self){
                            Text("\($0)")
                        }
                    }
                
                
                //Enter Amount
                HStack{
                    TextField("Amount", value: $amount , format: .currency(code:currency_selection))
                        .keyboardType(.decimalPad)
                    
                    Spacer()
                    
                    Picker("Currency:",selection: $currency_selection){
                        ForEach(currencies , id:\.self){
                            Text($0)
                        }
                    }
                    
                   
              
                }
                
              
                
            }
            .navigationTitle("Add New Expense")
            .toolbar{
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount , currencyType: currency_selection)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
