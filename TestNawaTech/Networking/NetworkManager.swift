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
    
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType,where predicate: NSPredicate? = nil, completion: @escaping(Result<[T], Error>) -> Void){
        var query: Query?
        var ref = Firestore.firestore().collection(reference.reference)
        
        if let predicate = predicate{
            query = Firestore.firestore().collection(reference.reference).filter(using: predicate).limit(to: 100)
        }else{
            query = Firestore.firestore().collection(reference.reference).limit(to: 100)
        }
        
        query?.getDocuments { collection, error in
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
    
    ///
    /// - Parameters:
    ///   - model: An encodable object
    ///   - reference: It should be path to Collection because it uses auto ID, if you want to determine your own document id you should use setDocument(with id: String..)
    ///   - completion: it will simply return the model that you put back if successful, or error.
    func setDocument<T: Encodable>(model: T,collection reference: FirestoreReferenceType, completion: @escaping(Result<T, Error>) -> Void){
        do{
            guard reference.type == .collection else{
                completion(.failure(CustomError.pathShouldBeCollection))
                return
            }
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
    
    ///
    /// - Parameters:
    ///   - model: An encodable object
    ///   - reference: It should be path to Document with an ID as the document ID (duh). If you do not want to determine the ID on your own and want to use collection path, use setDocument(model: T...)
    ///   - completion: it will simply return the model that you put back if successful, or error.
    func setDocument<T: Encodable>(model: T,document reference: FirestoreReferenceType, completion: @escaping(Result<T, Error>) -> Void){
        do{
            guard reference.type == .document else{
                completion(.failure(CustomError.pathShouldBeCollection))
                return
            }
            let data = try JSONEncoder().encode(model)
            let tempDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            Firestore.firestore().document(reference.reference).setData(tempDict) { error in
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
        setDocument(model: purchase, collection: .purchases) { (result: Result<Purchase, Error>) in
            completion(result)
        }
    }
}

protocol NetworkManagerProtocol{
    func fetchDocument<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping((Result<T, Error>) -> Void))
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType, where predicate: NSPredicate?, completion: @escaping(Result<[T], Error>) -> Void)
}
