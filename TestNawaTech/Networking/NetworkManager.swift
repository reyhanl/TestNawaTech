//
//  NetworkManager.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//


import Foundation
import FirebaseFirestore

class NetworkManager: NetworkManagerProtocol{
    
    static var shared = NetworkManager()
    
    func fetchDocument<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping((Result<T, Error>) -> Void)){
        Firestore.firestore().document(reference.reference).getDocument { document, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let dict = document?.data() else{return}
            do{
                let data = try JSONSerialization.data(withJSONObject: dict)
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            }catch{
                completion(.failure(error))
            }
        }
    }
    
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping(Result<[T], Error>) -> Void){
        Firestore.firestore().collection(reference.reference).getDocuments { collection, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let documents = collection?.documents else{return}
            let models: [T] = documents.compactMap({
                let dict = $0.data()
                do{
                    let data = try JSONSerialization.data(withJSONObject: dict)
                    let model = try JSONDecoder().decode(T.self, from: data)
                    return model
                }catch{
                    print(String(describing: error))
                    return nil
                }
            })
            completion(.success(models))
        }
    }
    
    func setDocument<T: Encodable>(model: T, reference: FirestoreReferenceType, completion: @escaping(Result<T, Error>) -> Void){
        do{
            let data = try JSONEncoder().encode(model)
            let tempDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            Firestore.firestore().collection(reference.reference).addDocument(data: tempDict) { error in
                if let error = error{
                    completion(.failure(error))
                    return
                }
                completion(.success(model))
            }
        }catch{
            completion(.failure(error))
        }
    }
    
    func purchase(purchase: Purchase, completion: @escaping(Result<Purchase, Error>) -> Void){
        //TODO: Check if user has balance
        setDocument(model: purchase, reference: .purchase) { (result: Result<Purchase, Error>) in
            completion(result)
        }
    }
}

protocol NetworkManagerProtocol{
    func fetchDocument<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping((Result<T, Error>) -> Void))
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping(Result<[T], Error>) -> Void)
}
