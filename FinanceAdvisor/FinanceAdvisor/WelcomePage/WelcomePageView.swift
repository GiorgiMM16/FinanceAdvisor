import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "0x181A20")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        Image("chat4")
                            .padding(.leading, -220)
                        Image("chat1")
                            .padding(.leading, 320)
                        Image("chat4")
                    }
                    Spacer()
                        .frame(height: 350)
                    
                    VStack {
                        Text("დაამატე შენი ხარჯები და მიიღე ფინანსური რჩევები")
                            .font(.custom("FiraGO-Regular", size: 30))
                            .foregroundColor(.white)
                            .frame(width: 314)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        Spacer()
                            .frame(height: 100)
                        HStack {
                            NavigationLink(destination: RegistrationPageView()) {
                                RoundedRectangle(cornerRadius: 24.0)
                                    .fill(Color(hex: "0x416EA4"))
                                    .frame(width: 158, height: 48)
                                    .overlay(
                                        Text("რეგისტრაცია")
                                            .foregroundColor(.white)
                                            .font(.custom("FiraGO-Regular", size: 18))
                                    )
                            }
                            Spacer()
                                .frame(width: 47)
                            NavigationLink(destination: LogInPageView()) {
                                RoundedRectangle(cornerRadius: 24.0)
                                    .fill(Color(hex: "0x416EA4"))
                                    .frame(width: 111, height: 48)
                                    .overlay(
                                        Text("შესვლა")
                                            .foregroundColor(.white)
                                            .font(.custom("FiraGO-Regular", size: 18))
                                    )
                            }
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // For full screen navigation on iPad
    }
}

#Preview {
    WelcomePageView()
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
