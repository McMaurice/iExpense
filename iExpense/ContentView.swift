//
//  ContentView.swift
//  iExpense
//
//  Created by Macmaurice Osuji on 3/8/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
   
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.listByType("Personal")) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer ()
                            Text(item.amount, format: .currency(code: item.currency))
                                .foregroundColor(item.amount <= 10 ? .red: .blue)
                        }
                    }
                    .onDelete(perform: expenses.removeItems(at:))
                } header: {
                    Text("Personal Expenses")
                        .font(.headline)
                }
            
                Section {
                    ForEach(expenses.listByType("Business")) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer ()
                            Text(item.amount, format: .currency(code: item.currency))
                                .foregroundColor(item.amount <= 10 ? .red: .blue)
                        }
                    }
                    .onDelete(perform: expenses.removeItems(at:))
                
                }header: {
                    Text("Business Expenses")
                        .font(.headline)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}///

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
