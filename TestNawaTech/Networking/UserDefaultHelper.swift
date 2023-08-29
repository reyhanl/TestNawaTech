//
//  UserDefaultHelper.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import Foundation

class UserDefaultHelper{
    static var shared = UserDefaultHelper()
    
    func retrieve<T>(userDefaultKey: UserDefaultKey) -> T?{
        let value = UserDefaults.standard.value(forKey: userDefaultKey.key) as? T
        return value
    }
    
    func store(_ value: Any, userDefaultKey: UserDefaultKey){
        UserDefaults.standard.setValue(value, forKey: userDefaultKey.key)
    }
    
    func getProfile() -> Profile?{
        if let data: Data = self.retrieve(userDefaultKey: .userProfile){
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(Profile.self, from: data)
                return model
            }catch{
                return nil
            }
        }
        return nil
    }
    
    func storeProfile(_ user: Profile){
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            self.store(data, userDefaultKey: .userProfile)
        }catch{
            print("Error: \(String(describing: error))")
        }
        
    }
}

enum UserDefaultKey{
    case userProfile
    case custom(String)
    
    var key: String{
        switch self{
        case .userProfile:
            return "userProfile"
        case .custom(let key):
            return key
        }
    }
}
