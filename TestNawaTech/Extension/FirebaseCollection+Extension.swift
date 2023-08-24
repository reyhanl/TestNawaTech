//
//  FirebaseCollection+Extension.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import FirebaseFirestore

extension Array where Element == QueryDocumentSnapshot{
    var data: Data?{
        do{
            let dicts = self.map({$0.data()})
            let data = try JSONSerialization.data(withJSONObject: dicts)
            return data
        }catch{
            return nil
        }
    }
}

