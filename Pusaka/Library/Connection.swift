//
//  Connection.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

class Connection {
    
    static let shared: Connection = {
       return Connection()
    }()
    
    typealias ConnectionResponse<T:Decodable> = ((ConnectionError?, T?) -> Void)
    
    func connect<T:Decodable>(_url: String, params: [String:Any], model: T.Type, completion: @escaping ConnectionResponse<T>) {
        guard Reachability.isConnectedToNetwork() else {
            completion(ConnectionError(errorCode: 0, errorMessage: "Tidak ada jaringan internet"), nil)
            return
        }
        guard let url = URL(string: _url) else {
            completion(ConnectionError(errorCode: 0, errorMessage: "Invalid Url"), nil)
            return
        }
        var post = ""
        for(key, value) in params { post.append("\(key)=\(value)")
            
        }
        let header: [String:String] = [ "Content-Type" : "application/x-www-form-urlencoded",
                                        "Authorization": "bearer " + (TokenManager.access_token ?? "") ]
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.timeoutInterval = 45
            request.httpBody = post.data(using: .utf8)
            request.allHTTPHeaderFields = header
        let task = URLSession.shared
        task.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(ConnectionError(errorCode: 0, errorMessage: error!.localizedDescription), nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(ConnectionError(errorCode: 0, errorMessage: "Tidak ada respon dari server"), nil)
                return
            }
            guard let data = data else {
                completion(ConnectionError(errorCode: 0, errorMessage: "Tidak ada data dari server"), nil)
                return
            }
            if let response = String(data: data, encoding: .utf8) {
                print(response)
            }
            guard httpResponse.statusCode != 401 else {
                let tokenParam = ["grant_type": "password"]
                Connection.shared.connect(_url: NetworkConst.token, params: tokenParam, model: Token.self) { (error, token) in
                    guard error == nil else {
                        completion(ConnectionError(errorCode: error!.errorCode, errorMessage: error!.errorMessage), nil)
                        return
                    }
                    guard let token = token else {
                        return
                    }
                    TokenManager.access_token = token.access_token
                    TokenManager.expires_in   = token.expires_in
                    TokenManager.sid          = token.sid
                    Connection.shared.connect(_url: _url, params: params, model: model, completion: completion)
                }
                return
            }
            print("Response code: ", httpResponse.statusCode)
            guard httpResponse.statusCode == 200 else {
                if let response = String(data: data, encoding: .utf8) {
                    completion(ConnectionError(errorCode: httpResponse.statusCode, errorMessage: response), nil)
                }
                return
            }
            guard let responseModel = try? JSONDecoder().decode(T.self, from: data) else {
                completion(ConnectionError(errorCode: 0, errorMessage: "Failed to decode JSON"), nil)
                return
            }
            completion(nil, responseModel)
        }.resume()
    }
}
