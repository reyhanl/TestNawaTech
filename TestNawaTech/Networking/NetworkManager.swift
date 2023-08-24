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
}

protocol NetworkManagerProtocol{
    func fetchDocument<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping((Result<T, Error>) -> Void))
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping(Result<[T], Error>) -> Void)
}
