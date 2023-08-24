//
//  MockDataProvider.swift
//  TestNawaTechUITests
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

class MockDataProvider{
    static func generateMotorcycles() -> [Motorcycle]{
        let motorCycle1 = Motorcycle(name: "R16", company: "Yamaha", imageUrl: "https://firebasestorage.googleapis.com/v0/b/nawatechtest.appspot.com/o/Images%2Fr15.png?alt=media&token=bc73c0cb-373e-4dad-bb1e-5bc4798c184f")
        let motorCycle2 = Motorcycle(name: "Beat", company: "Yamaha", imageUrl: "https://firebasestorage.googleapis.com/v0/b/nawatechtest.appspot.com/o/Images%2FHondaBeat.png?alt=media&token=c4172213-7559-4b56-b953-3d35bee3b279")
        return [motorCycle1, motorCycle2]
    }
}
