//
//  AddView.swift
//  iExpense
//
//  Created by Macmaurice Osuji on 3/8/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "".uppercased()
    
    @State private var errorTitle = ""
    @State private var errorMassage = ""
    @State private var showingError = false

    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Expense Name", text: $name)
                    
                    Picker("Expense type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .pickerStyle(.menu)
                Section {
                    TextField("input amount", value: $amount, format: .currency(code: currency))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    TextField("Enter currency code", text: $currency)
    
                } header: {
                    Text("Enter amount spent")
                }
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let data = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    expenses.items.append(data)
                    dismiss()
                }
            }
           
        }
    }
    
}///

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
