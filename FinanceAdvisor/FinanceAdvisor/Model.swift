//
//  Model.swift
//  FinanceAdvisor
//
//  Created by Giorgi Michitashvili on 7/5/24.
//

import Foundation
import SwiftUI

struct Expense: Identifiable {
    let id = UUID()
    let categoryColor: Color
    let name: String
    let amount: String
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
