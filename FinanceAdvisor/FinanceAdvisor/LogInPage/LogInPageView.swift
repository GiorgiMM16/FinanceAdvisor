import SwiftUI

struct LogInPageView: View {
    @StateObject private var viewModel = LogInViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToExpensesPage = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "0x181A20")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("შესვლა")
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
                                TextField("Email", text: $viewModel.username)
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
                                SecureField("Password", text: $viewModel.password)
                                    .padding()
                                    .foregroundColor(.white)
                            )
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                        .frame(height: 400)
                    
                    NavigationLink(destination: ExpensesPageView(), isActive: $navigateToExpensesPage) {
                        Button(action: {
                            viewModel.validateInputs { isValid, message in
                                if isValid {
                                    navigateToExpensesPage = true
                                } else {
                                    alertMessage = message
                                    showAlert = true
                                }
                            }
                        }, label: {
                            RoundedRectangle(cornerRadius: 24.0)
                                .fill(Color(hex: "0x416EA4"))
                                .frame(width: 158, height: 48)
                                .overlay(
                                    Text("შესვლა")
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
}
