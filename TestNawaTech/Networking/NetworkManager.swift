//
//  NetworkManager.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

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
    
    func updateUserData(profile: Profile, completion: @escaping(Error?) -> Void) {
        guard let id = profile.id else{return}
        NetworkManager.shared.setDocument(model: profile, document: .user(id)) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func purchase(purchase: Purchase, completion: @escaping(Result<Purchase, Error>) -> Void){
        fetchProfile { result in
            switch result{
            case .success(let profile):
                checkBalance(profile: profile)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        func checkBalance(profile: Profile){
            guard var balance = profile.balance, let total = purchase.total else{return}
            if balance > total{
                balance -= total
                profile.balance = balance
                self.updateUserData(profile: profile, completion: { error in
                    if let error = error{
                        completion(.failure(error))
                    }else{
                        NotificationCenter.default.post(name: .userDataHasBeenUpdated, object: profile)
                        addToPurchasedMotorcycle()
                    }
                })
            }else{
                completion(.failure(CustomError.notEnoughBalance))
            }
        }
        
        func addToPurchasedMotorcycle(){
            setDocument(model: purchase, document: .purchase(purchase.transactionId ?? "")) { result in
                switch result {
                case .success(let purchase):
                    completion(.success(purchase))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchProfile(completion: @escaping(Result<Profile, Error>) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else{return}
        NetworkManager.shared.fetchDocument(reference: .user(id)) { [weak self] (result: Result<Profile, Error>) in
            guard let self = self else{
                return
            }
            switch result{
            case .success(let profile):
                completion(.success(profile))
                NotificationCenter.default.post(name: .userDataHasBeenUpdated, object: profile)
            case .failure(let error):
                completion(.failure(CustomError.somethingWentWrong))
            }
        }
    }
}

protocol NetworkManagerProtocol{
    func fetchDocument<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping((Result<T, Error>) -> Void))
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType, where predicate: NSPredicate?, completion: @escaping(Result<[T], Error>) -> Void)
}
