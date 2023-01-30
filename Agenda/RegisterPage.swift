import SwiftUI

struct RegisterPage: View {
    @State var email = ""
    @State var password = ""
    @State var register = false
    
    var body: some View {
        
        VStack{
            
            Text("Bienvenido a la Agenda")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("dark"))
                .kerning(1.9) //Espacio entre las letras
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("¡¡Registrate a continuación!!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("dark"))
                .kerning(1.9) //Espacio entre las letras
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Añade un Nombre de Usuario")
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
            
            Button(action: {
                registerPost(email: email, password: password)
            }) {
                Text("Registrarse")
            }
            
            NavigationLink(destination: Menu(), isActive: $register) {
                EmptyView()
            }
        }
        .padding()
    }
    
    func registerPost (email: String, password: String) {
    
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
            return
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
                
            register = true
        }
        task.resume()
    }
}



struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
