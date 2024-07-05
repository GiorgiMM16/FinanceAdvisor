//
//  RegistrationPageView.swift
//  FinanceAdvisor
//
//  Created by Giorgi Michitashvili on 7/5/24.
//

import SwiftUI

struct RegistrationPageView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var income: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToExpensesPage = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "0x181A20")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("რეგისტრაცია")
                        .font(.custom("FiraGO-Regular", size: 30))
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height: 70)
                    VStack {
                        Text("შეიყვანეთ მეილი")
                            .font(.custom("FiraGO-Regular", size: 15))
                            .foregroundColor(.gray)
                            .padding(.leading, -160)
                        
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(height: 48)
                            .overlay(
                                TextField("Email", text: $username)
                                    .padding()
                                    .foregroundColor(.white)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            )
                            .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 16)
                        
                        Text("შეიყვანეთ პაროლი")
                            .font(.custom("FiraGO-Regular", size: 15))
                            .foregroundColor(.gray)
                            .padding(.leading, -160)
                        
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(height: 48)
                            .overlay(
                                SecureField("Password", text: $password)
                                    .padding()
                                    .foregroundColor(.white)
                            )
                            .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 60)
                        
                        Text("შეიყვანეთ ყოველთვიური შემოსავალი")
                            .font(.custom("FiraGO-Regular", size: 15))
                            .foregroundColor(.gray)
                            .padding(.leading, -30)
                        
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(height: 48)
                            .overlay(
                                TextField("Income", text: $income)
                                    .padding()
                                    .foregroundColor(.white)
                                    .keyboardType(.numberPad)
                                    .onChange(of: income) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.income = filtered
                                        }
                                    }
                            )
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                        .frame(height: 270)
                    
                    NavigationLink(destination: ExpensesPageView(), isActive: $navigateToExpensesPage) {
                        Button(action: {
                            validateInputs()
                        }, label: {
                            RoundedRectangle(cornerRadius: 24.0)
                                .fill(Color(hex: "0x416EA4"))
                                .frame(width: 158, height: 48)
                                .overlay(
                                    Text("რეგისტრაცია")
                                        .foregroundColor(.white)
                                        .font(.custom("FiraGO-Regular", size: 18))
                                )
                        })
                    }
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Input Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func validateInputs() {
        if username.isEmpty {
            alertMessage = "Please enter an email address."
            showAlert = true
            return
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: username) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        if password.isEmpty {
            alertMessage = "Please enter a password."
            showAlert = true
            return
        }
        
        if income.isEmpty {
            alertMessage = "Please enter your monthly income."
            showAlert = true
            return
        }
        
        navigateToExpensesPage = true
    }
}


#Preview {
    RegistrationPageView()
}
