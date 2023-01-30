import SwiftUI

struct CreateEvent: View {
    @State var name = ""
    @State var date = Date()
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Crear Evento")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("dark"))
                    .kerning(1.9) //Espacio entre las letras
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Nombre del Evento")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("Nombre", text: $name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("dark"))
                        .padding(.top, 5)
                        .keyboardType(.emailAddress)
                    Divider()
                })
                
                .padding(.top, 25)
                VStack(alignment: .leading, spacing: 8, content: {
                    DatePicker("Fecha", selection: $date)
                    Divider()
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                Button(action: {
                    requestPost(name: name, date: date)
                }, label : {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("dark"))
                        .clipShape(Circle())
                        .shadow(color: Color("lightPink").opacity(0.6), radius: 5, x: 0, y: 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                })
            }
            .padding()
        }

    }
}

struct CreateEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateEvent()
    }
}
