//
//  MockDataProvider.swift
//  TestNawaTechUITests
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

class MockDataProvider{
    static func generateMotorcycles() -> [MotorcycleModel]{
        let motorCycle1 = MotorcycleModel(name: "R16", company: "Yamaha", imageUrl: "https://firebasestorage.googleapis.com/v0/b/nawatechtest.appspot.com/o/Images%2Fr15.png?alt=media&token=bc73c0cb-373e-4dad-bb1e-5bc4798c184f",  thumbImageUrl: "https://firebasestorage.googleapis.com/v0/b/nawatechtest.appspot.com/o/Images%2FR15%2FthumbImager15.png?alt=media&token=025e41b2-ce85-4c54-a8da-45c94d6d6688")
        let motorCycle2 = MotorcycleModel(name: "Beat", company: "Yamaha", imageUrl: "https://firebasestorage.googleapis.com/v0/b/nawatechtest.appspot.com/o/Images%2FR15%2Fr15.png?alt=media&token=13e95e8e-333c-4d12-b889-41b50cf2f2a5", thumbImageUrl: "https://firebasestorage.googleapis.com/v0/b/nawatechtest.appspot.com/o/Images%2FR15%2FthumbImager15.png?alt=media&token=025e41b2-ce85-4c54-a8da-45c94d6d6688")
        return [motorCycle1, motorCycle2]
    }
}
