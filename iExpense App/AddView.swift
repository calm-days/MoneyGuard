

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var currency = "PLN"
    @State private var amount = 0.0
    
    let types = ["Personal", "Business"]
    let currencies = ["USD", "PLN"]
    
    var body: some View {

        NavigationView {
            
            Form {
                
                Section {
                    TextField("Name", text: $name)
                   
                    Picker ("Types", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Picker ("Currency", selection: $currency) {
                        ForEach(currencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Amount", value: $amount, format: .currency(code: "\(currency)"))
                        .keyboardType(.decimalPad)
                        .id(currency)
                }
                
                
               
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button ("Save") {
                    let item = ExpenseItem(name: name, type: type, currency: currency, amount: amount)
                    withAnimation {expenses.items.append(item)}
                    
                    dismiss()
                    
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
