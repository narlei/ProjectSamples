//
//  SBServiceExtension.swift
//  SocialBase
//
//  Created by Narlei A Moreira on 11/08/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

extension Moya.Response {
    
    /// Parseia o retorno paseado em um dic com ["items" : []]
    func convert<T:Mappable>(classe: T.Type) -> [Any] {
        
        // Deu erro
        if self.statusCode != 200 {

        }
        
        let arrayReturn = NSMutableArray()
        do {
            let dictionary = try self.mapJSON() as? [String:Any]
            if let itemsArray = dictionary!["items"] as? [[String:Any]]{
                for dic in itemsArray{
                    if let value = classe.init(JSON: dic) {
                        arrayReturn.add(value)
                    }
                }
            }
        } catch {
            
        }
        return arrayReturn as! [Any]
    }
    
    /// Parseia o retorno paseado em um dic com ["items" : []]
    func convert2<T:Mappable>(classe: T.Type) -> [Any] {
        
        // Deu erro
        if self.statusCode != 200 {
            
        }
        
        let arrayReturn = NSMutableArray()
        do {
            let dictionary = try self.mapJSON() as? [[String:Any]]
            if let itemsArray = dictionary{
                for dic in itemsArray{
                    if let value = classe.init(JSON: dic) {
                        arrayReturn.add(value)
                    }
                }
            }
        } catch {
            
        }
        return arrayReturn as! [Any]
    }
    
    func isValid() -> Bool {
        return (self.statusCode >= 200 && self.statusCode < 300)
    }
    
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}


// MARK: - Provider setup

func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}
