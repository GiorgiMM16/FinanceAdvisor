import Foundation

class LogInViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    // Validation and navigation logic can be implemented here
    func validateInputs(completion: @escaping (Bool, String) -> Void) {
        if username.isEmpty {
            completion(false, "Please enter an email address.")
            return
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: username) {
            completion(false, "Please enter a valid email address.")
            return
        }
        
        if password.isEmpty {
            completion(false, "Please enter a password.")
            return
        }
        
        completion(true, "")
    }
}
