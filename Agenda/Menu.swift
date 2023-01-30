import SwiftUI

struct Menu: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Menu")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("dark"))
                    .kerning(1.9) //Espacio entre las letras
                NavigationLink("Lista de Eventos", destination: EventList())
                    .padding(.top, 18)
                    .buttonStyle(.bordered)
                NavigationLink("Crear Eventos", destination: CreateEvent())
                    .padding(.top, 18)
                    .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
