//
//  Expenseitem.swift
//  iExpense App
//
//  Created by Roman Liukevich on 8/28/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    //identifiable so that it won't be needed adding id: \.id for foreach loop
    //codeable for saving userdefaults
    var id = UUID()
    let name: String
    let type: String
    let currency: String
    let amount: Double
}
