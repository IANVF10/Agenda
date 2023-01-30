import Foundation


struct EventoDataModel: Decodable {
    let name: String
    let date: Double
}

struct EventoResponseDataModel: Decodable {
    let eventos: [EventoDataModel]
    
    enum CodingKeys: String, CodingKey{
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventos = try container.decode([EventoDataModel].self, forKey: .results)
    }
}

final class ViewModel: ObservableObject {
    
    @Published var events: [EventoDataModel] = []
    
    func getEventos() {
        let url = URL(string: "https://superapi.netlify.app/api/db/eventos")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                let eventoDataModel = try! JSONDecoder().decode([EventoDataModel].self, from: data)
                print("Eventos \(eventoDataModel)")
                self.events = eventoDataModel
            }
        }.resume()
    }
    
}
