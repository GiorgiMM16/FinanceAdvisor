import SwiftUI

struct ExpensesPageView: View {
    @StateObject private var viewModel = ExpensesPageViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "0x181A20")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Text("გამარჯობა, დაჩი")
                            .font(.custom("FiraGO-Regular", size: 30))
                            .foregroundColor(.white)
                        Spacer()
                            .frame(width: 43)
                        Image("pic1")
                    }
                    .padding()
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.expenses) { expense in
                                VStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(expense.categoryColor)
                                        .frame(height: 100)
                                        .overlay(
                                            VStack {
                                                Text(expense.name)
                                                    .font(.custom("FiraGO-Regular", size: 18))
                                                    .foregroundColor(.white)
                                            }
                                        )
                                }
                                .padding()
                            }
                        }
                        .padding()
                        
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.vertical, 5)
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
                                } else {
                                    Text(message.text)
                                        .padding()
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.vertical, 5)
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack (spacing: 10) {
                        RoundedRectangle(cornerRadius: 20.0)
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(height: 48)
                            .overlay(
                                TextField("Enter message", text: $viewModel.prompt)
                                    .padding()
                                    .foregroundColor(.white)
                                    .keyboardType(.default)
                                    .autocapitalization(.none)
                            )
                            .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.sendMessageToAPI()
                        }) {
                            RoundedRectangle(cornerRadius: 24.0)
                                .fill(Color(hex: "0x416EA4"))
                                .frame(width: 55, height: 48)
                                .overlay(
                                    Image("bubble")
                                )
                        }
                        .padding(.bottom, 5)
                    }
                }
            }
        }
    }
}

struct ExpensesPageView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesPageView()
    }
}
