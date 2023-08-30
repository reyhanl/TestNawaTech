//
//  NetworkManager.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth
import OSLog

class NetworkManager: NetworkManagerProtocol{
    
    static var shared = NetworkManager()
    
    func fetchDocument<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping((Result<T, Error>) -> Void)){
        os_log("user just fetch data from Firestore/%@", type: .info, reference.reference)
        Firestore.firestore().document(reference.reference).getDocument { document, error in
            if let error = error{
                os_log("something went wrong", type: .info, error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard let dict = document?.data() else{return}
            do{
                let data = try JSONSerialization.data(withJSONObject: dict)
                let model = try JSONDecoder().decode(T.self, from: data)
                os_log("fetch data from firestore/%@  is successful", type: .info, reference.reference)
                completion(.success(model))
            }catch{
                os_log("something went wrong", type: .info, error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType,where predicate: NSPredicate? = nil, completion: @escaping(Result<[T], Error>) -> Void){
        os_log("user just fetch data from Firestore/%@", type: .info, reference.reference)
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
                    os_log("fetch data from firestore/%@  is successful", type: .info, reference.reference)
                    return model
                }catch{
                    os_log("something went wrong", type: .info, error.localizedDescription)
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
        os_log("update document in Firestore/%@", type: .info, reference.reference)
        do{
            guard reference.type == .collection else{
                completion(.failure(CustomError.pathShouldBeCollection))
                return
            }
            let data = try JSONEncoder().encode(model)
            let tempDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            Firestore.firestore().collection(reference.reference).addDocument(data: tempDict) { error in
                if let error = error{
                    os_log("something went wrong %@", type: .info, error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                os_log("succesfully updating data in Firestore/%@", type: .info, reference.reference)
                completion(.success(model))
            }
        }catch{
            os_log("something went wrong %@", type: .info, error.localizedDescription)
            completion(.failure(error))
        }
    }
    
    ///
    /// - Parameters:
    ///   - model: An encodable object
    ///   - reference: It should be path to Document with an ID as the document ID (duh). If you do not want to determine the ID on your own and want to use collection path, use setDocument(model: T...)
    ///   - completion: it will simply return the model that you put back if successful, or error.
    func setDocument<T: Encodable>(model: T,document reference: FirestoreReferenceType, completion: @escaping(Result<T, Error>) -> Void){
        os_log("update document in Firestore/%@", type: .info, reference.reference)
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
                    os_log("something went wrong %@", type: .info, error.localizedDescription)
                    return
                }
                os_log("succesfully updating data in Firestore/%@", type: .info, reference.reference)
                completion(.success(model))
            }
        }catch{
            os_log("something went wrong %@", type: .info, error.localizedDescription)
            completion(.failure(error))
        }
    }
    
    func updateDocumentField(key: String, value: Any, document reference: FirestoreReferenceType, completion: @escaping(Error?) -> Void){
        os_log("update document in Firestore/%@", type: .info, reference.reference)
        os_log("changing %@", type: .info, key)
        guard reference.type == .document else{
            completion(CustomError.pathShouldBeDocument)
            return
        }
        Firestore.firestore().document(reference.reference).updateData([key: value]) { error in
            if let error = error{
                completion(error)
                os_log("something went wrong %@", type: .info, error.localizedDescription)
                return
            }
            os_log("succesfully updating %@", type: .info, key)
            completion(nil)
        }
    }

    
    func updateUserData(profile: UserProfileModel, completion: @escaping(Error?) -> Void) {
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
    
    func purchase(purchase: PurchaseModel, completion: @escaping(Result<PurchaseModel, Error>) -> Void){
        os_log("User try to purchase %@", type: .info, purchase.motorcycleId ?? "")
        fetchProfile { result in
            switch result{
            case .success(let profile):
                checkBalance(profile: profile)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        func checkBalance(profile: UserProfileModel){
            guard var balance = profile.balance, let total = purchase.total else{return}
            if balance > total{
                balance -= total
                profile.balance = balance
                self.updateDocumentField(key: UserProfileModel.CodingKeys.balance.rawValue, value: balance, document: .user(profile.id ?? "")) { [weak self] error in
                    if let error = error{
                        completion(.failure(error))
                    }else{
                        self?.fetchProfile(completion: nil)
                        addToPurchasedMotorcycle()
                    }
                }
            }else{
                os_log("fail to purchase because not enough balance")
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
    
    func fetchProfile(completion: ((Result<UserProfileModel, Error>) -> Void)?) {
        os_log("User try to fetch profile")
        guard let id = Auth.auth().currentUser?.uid else{return}
        NetworkManager.shared.fetchDocument(reference: .user(id)) { [weak self] (result: Result<UserProfileModel, Error>) in
            guard let self = self else{
                return
            }
            switch result{
            case .success(let profile):
                completion?(.success(profile))
                NotificationCenter.default.post(name: .userDataHasBeenUpdated, object: profile)
                os_log("Calling NotificationCenter to update profile")
            case .failure(let error):
                os_log("failed to fetch profile data %@", type: .info, error.localizedDescription)
                completion?(.failure(CustomError.somethingWentWrong))
            }
        }
    }
    
    func topUp(topUp: TopUpModel, completion: @escaping(Error?) -> Void){
        os_log("User try to top up")
        fetchProfile { result in
            switch result{
            case .success(let profile):
                updateUserBalance(user: profile)
            case .failure(let error):
                completion(error)
            }
        }
        
        func updateUserBalance(user: UserProfileModel){
            guard let user = UserDefaultHelper.shared.getProfile(), var balance = user.balance, let topUpAmount = topUp.amount else{
                completion(CustomError.somethingWentWrong)
                return
            }
            balance += topUpAmount
            user.balance = balance
            setDocument(model: user, document: .user(user.id ?? "")) { (result: Result<UserProfileModel, Error>) in
                switch result{
                case .success(_):
                    os_log("Successfully adding user's balance")
                    addTopUpHistory(user: user)
                case .failure(let error):
                    os_log("failed to fetch profile data %@", type: .info, error.localizedDescription)
                    completion(error)
                }
            }
        }
        
        func addTopUpHistory(user: UserProfileModel){
            let id = UUID().uuidString
            let topUpHistory = TopUpHistory(userId: user.id, topUp: topUp.id, date: Date().getString(format: Date.defaultDateFormat), id: id)
            setDocument(model: topUpHistory, document: .transaction(id), completion: { (result: Result<TopUpHistory, Error>) in
                switch result{
                case .success(_):
                    completion(nil)
                    os_log("Successfully adding to top up history (Firestore/transaction)")
                    NotificationCenter.default.post(name: .userDataHasBeenUpdated, object: user)
                case .failure(let error):
                    os_log("failed to fetch profile data %@", type: .info, error.localizedDescription)
                    completion(error)
                }
            })
        }
    }
}
                                            
                                            
protocol NetworkManagerProtocol{
    func fetchDocument<T:Decodable>(reference: FirestoreReferenceType, completion: @escaping((Result<T, Error>) -> Void))
    func fetchCollection<T:Decodable>(reference: FirestoreReferenceType, where predicate: NSPredicate?, completion: @escaping(Result<[T], Error>) -> Void)
}
