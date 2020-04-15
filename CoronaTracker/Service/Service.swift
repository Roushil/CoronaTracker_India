//
//  Service.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/12/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import UIKit

class Service: NSObject{
    class func getJSONData(completion: @escaping (_ gotData: Bool) -> ()){
        
        guard let url = URL(string: "https://....") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let coronaInfo = data else { return }
            do{
                
                let results = try JSONDecoder().decode(Json4Swift_Base.self, from: coronaInfo)
                DataViewModel.shared.history = results.data?.history
                completion(true)
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }.resume()
        
    }
}
