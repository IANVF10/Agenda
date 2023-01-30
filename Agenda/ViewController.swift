//
//  ViewController.swift
//  Agenda
//
//  Created by Apps2M on 25/1/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var textNamePost: UITextField!
    @IBOutlet weak var textDatePost: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendDataToServer(_ sender: Any) {
        let alert = UIAlertController(title: "Enviar Datos", message: "Se enviará la información al servidor principal", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style:.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: {
            action in
            guard let name = self.textNamePost.text else {print("No hay un nombre valido"); return}
            guard let date = self.textDatePost.text else {print("No hay fecha valida"); return}
            
            let datos = Datos(name: name, date: date)
            let postRequest = APIRequest(endpoint: "post")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("El siguiente mensaje ha sido enviado nombre \(datos.name)\n fecha:\(datos.date)")
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                }
            })
        }))
        self.present(alert, animated: true)
    }
}




