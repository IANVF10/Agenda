//
//  RequestEvent.swift
//  Agenda
//
//  Created by Apps2M on 25/1/23.
//

import Foundation

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest {
    let resourceURL : URL
    
    init(endpoint:String) {
        let baseURL = "https://superapi.netlify.app/api/db/eventos"
        guard let resorceURL = URL(string: baseURL) else {fatalError()}
        
        self.resourceURL = resorceURL
    }
    
    func save(_ dataToSave:Datos, completion: @escaping(Result<Datos, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(dataToSave)
            let task = URLSession.shared.dataTask(with: urlRequest){
                data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 201, let JSONData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let contentData = try JSONDecoder().decode(Datos.self, from: JSONData)
                    completion(.success(contentData))
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            task.resume()
        }
        catch {
            completion(.failure(.encodingProblem))
        }
    }
}







