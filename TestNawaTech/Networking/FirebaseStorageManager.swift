//
//  FirebaseStorageManager.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import Foundation
import FirebaseStorage

class FirebaseStorageManager{
    static var shared = FirebaseStorageManager()
    
    func uploadImage(data: Data, reference type: FirebaseStorageType, completion: @escaping(Result<URL, Error>) -> Void){
        let root = Storage.storage().reference()
        let destinationRef = root.child(type.reference)
        destinationRef.putData(data) { metaData, error in
            if let error = error{
                completion(.failure(error))
            }
            let downloadUrl = destinationRef.downloadURL { url, error in
                guard let url = url else{
                    completion(.failure(error ?? CustomError.somethingWentWrong))
                    return
                }
                completion(.success(url))
            }
        }
    }
}
