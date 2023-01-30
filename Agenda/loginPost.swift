import Foundation

func loginPost (email: String, password: String) -> Bool {
    
    var loginSuccessful = false
    
    let datos: [String: Any] = [
        "user": email,
        "pass": password
    ]
    
    let url = URL(string: "https://superapi.netlify.app/api/login")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: datos, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
        return loginSuccessful
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
        if let error = error {
            print("Post Request Error: \(error.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            print("Invalid Response")
            return
        }
        
        loginSuccessful = true
    }
    task.resume()
    
    return loginSuccessful
}
