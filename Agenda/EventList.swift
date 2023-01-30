import SwiftUI

struct EventList: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
            Form{
                ForEach(viewModel.events, id: \.name) { eventos in
                    HStack {
                        Text(eventos.name)
                        Text(eventos.date.description)
                    }
                }
            }
            .navigationTitle("Lista de Eventos")
            .onAppear{
            viewModel.getEventos()
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
