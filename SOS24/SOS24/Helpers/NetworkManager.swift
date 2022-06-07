//
//  NetworkManager.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 09.03.2021.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    func sendData(application: Application, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        AF.request("", method: .post, parameters: application, encoder:  URLEncodedFormParameterEncoder(destination: .httpBody), headers: ["Accept":"application/json", "Content-Type":"application/x-www-form-urlencoded"]).response { response in
            switch response.result {
            case .success:
                success()
            case .failure(let error):
                failure(error)
            }
        }
    }
}
