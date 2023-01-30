import SwiftUI

struct LoginPage: View {
    @State var email = ""
    @State var password = ""
    @State var login = false
    
    var body: some View {
        NavigationView {
            VStack{
                Text("¡¡Hola de nuevo!!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("dark"))
                    .kerning(1.9) //Espacio entre las letras
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Bienvenido a la Agenda")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("dark"))
                    .kerning(1.9) //Espacio entre las letras
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Nombre de Usuario")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("Ianvf10", text: $email)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("dark"))
                        .padding(.top, 5)
                        .keyboardType(.emailAddress)
                    Divider()
                })
                
                .padding(.top, 25)
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Contraseña")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    SecureField("12345", text: $password)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("dark"))
                        .padding(.top, 5)
                    Divider()
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                
                Button(action: {
                    loginPost(email: email, password: password)
                }) {
                    Text("Iniciar sesión")
                }
                
                NavigationLink(destination: Menu(), isActive: $login) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
    
    func loginPost (email: String, password: String) {
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
            return
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
            
            login = true
        }
        task.resume()
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
