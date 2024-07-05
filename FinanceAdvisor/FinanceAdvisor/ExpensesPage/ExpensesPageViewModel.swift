import Foundation

class ExpensesPageViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var messages: [Message] = []
    @Published var prompt: String = ""
    
    private let apiURL = "http://10.147.17.21:8000/api/analyze/"
    
    init() {
        fetchInitialExpenses()
    }
    
    func fetchInitialExpenses() {
        // Normally, you would fetch expenses from a local or remote source.
        // For demo purposes, initializing with hardcoded data.
        expenses = [
            Expense(categoryColor: .red, name: "საყიდლები", amount: "200₾"),
            Expense(categoryColor: .blue, name: "ქირა", amount: "1200₾"),
            Expense(categoryColor: .green, name: "საწვავი", amount: "150₾")
        ]
    }
    
    func sendMessageToAPI() {
        let userMessage = Message(text: prompt, isUser: true)
        messages.append(userMessage)
        
        sendToAPI(prompt: prompt) { [weak self] response in
            let botMessage = Message(text: response, isUser: false)
            DispatchQueue.main.async {
                self?.messages.append(botMessage)
            }
        }
        
        prompt = ""
    }
    
    private func sendToAPI(prompt: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["financial_question": prompt]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                print("Headers: \(httpResponse.allHeaderFields)")
            }
            
            guard let data = data else {
                completion("No data received")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let analysis = jsonResponse["analysis"] as? String {
                        completion(analysis)
                    } else if let errorMessage = jsonResponse["error"] as? String {
                        completion("Error from API: \(errorMessage)")
                    } else {
                        completion("Unexpected response format")
                    }
                } else {
                    completion("Invalid response format")
                }
            } catch {
                completion("Error parsing response: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
