//
//  ContentView.swift
//  iExpense App
//
//  Created by Roman Liukevich on 8/28/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    

    
    var computatedTotalExpenses: Double {

        var totalAmount = 0.0
        for item in expenses.items {
            if item.currency == "USD" {
                totalAmount += item.amount
            } else { totalAmount += item.amount/4.7 }
            
        }
        
        return totalAmount
    }
    
    var body: some View {

        NavigationView {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack {
                        VStack (alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "\(item.currency)"))
                            .foregroundColor(item.currency == "PLN" ? .red : .orange)
                    }
                }
                .onDelete(perform: removeItems)
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                   
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Total: ")
                                .font(.title2.bold())
                            Text("\(String(format: "%.1f", computatedTotalExpenses)) USD")
                                .font(.title2)
                        }
                        
                        Spacer()
                        VStack (alignment: .leading){
                            
                            Text("Nr of records: \(expenses.items.count)")
                                .padding(1)
                            Text("PLN: \(String(format: "%.1f", computatedTotalExpenses*4.7))")
                                .padding(1)
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(15)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    .offset(x: 0, y: -15)
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
