//
//  ViewController.swift
//  ProjectSample
//
//  Created by Narlei A Moreira on 14/08/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import Moya
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserByName(name: "narlei")
        let fm = FileManager.default
        let fileURL = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        print(fileURL)
    }
    
    func getUserByName(name:String) {
        PSUserProvider.request(.search(query: name)) { (result) in
            if case let .success(response) = result {
                let array = response.convert(classe: PSUser.self)
                if let user = array.first as? PSUser {
                    self.getDirectories(user: user.login!)
                    self.save(user: user)
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
    
    func save(user:PSUser) {
        // Get the default Realm
        let realm = try! Realm()
        // You only need to do this once (per thread)
        
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(user, update: true)
        }
        
        let results = realm.objects(PSUser.self).filter(NSPredicate(format: "login contains 'na'"))
        print("\nTotal: \(results.count)\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

