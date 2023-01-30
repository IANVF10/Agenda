import Foundation

func registerPost (email: String, password: String) -> Bool {
    
    var registerSuccessful = false
    
    let datos: [String: Any] = [
        "user": email,
        "pass": password
    ]
    
    let url = URL(string: "https://superapi.netlify.app/api/register")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: datos, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
        return registerSuccessful
    }
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...209).contains(httpResponse.statusCode)
        else {
            print("Invalid Response")
            return
        }
            
        registerSuccessful = true
    }
    task.resume()
    
    return registerSuccessful
}
