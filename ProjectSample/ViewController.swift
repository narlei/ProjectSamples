//
//  ViewController.swift
//  ProjectSample
//
//  Created by Narlei A Moreira on 14/08/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserByName(name: "narlei")
    }
    
    func getUserByName(name:String) {
        PSUserProvider.request(.search(query: name)) { (result) in
            if case let .success(response) = result {
                let array = response.convert(classe: PSUser.self)
                if let user = array.first as? PSUser {
                    self.getDirectories(user: user.login!)
                }
            }
        }
    }
    
    func getDirectories(user:String) {
        PSUserProvider.request(.repositories(userId: user), completion: { (result) in
            if case let .success(response) = result {
                let array = response.convert2(classe: PSRepository.self)
                print(array)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

