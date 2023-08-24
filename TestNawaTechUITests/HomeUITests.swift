//
//  HomeUITests.swift
//  TestNawaTechUITests
//
//  Created by reyhan muhammad on 24/08/23.
//

import XCTest

final class HomeUITests: XCTestCase {

    var app: XCUIApplication?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testLaunchHome() throws {
        guard let app = app else{return}
        app.launchArguments = ["HomeUITests"]
        app.launch()
        let title = app.title
        print(title)
        XCTAssertTrue(app.staticTexts["Motorcycle Catalog"].exists)
    }
    
//    func testRefreshNewData() throws {
//        guard let app = app else{return}
//        app.launchArguments = ["HomeUITests"]
//        app.launch()
//        let collectionView = app.collectionViews["MotorcycleCatalogCollectionView"]
//        let firstCell = collectionView.cells["MotorcycleCatalogCollectionViewCell"].firstMatch
//        let cellCount = collectionView.cells.count
//        let start = firstCell.coordinate(withNormalizedOffset: CGVectorMake(0, 0))
//        let finish = firstCell.coordinate(withNormalizedOffset: CGVectorMake(0, app.frame.height / 2))
//        start.press(forDuration: 0, thenDragTo: finish, withVelocity: 1, thenHoldForDuration: 0)
//        let cellCountAfterRefresh = collectionView.cells.count
//        XCTAssertTrue(cellCount != cellCountAfterRefresh)
//    }
//    
//    func testTapOnCell() throws {
//        guard let app = app else{return}
//        app.launchArguments = ["HomeUITests"]
//        app.launch()
//        let collectionView = app.collectionViews.matching(identifier: "MotorcycleCatalogCollectionView")
//        let firstCell = collectionView.cells.matching(identifier: "MotorcycleCatalogCollectionViewCell0")
//        firstCell.element.tap()
//        XCTAssertTrue(!app.staticTexts["Motorcycle Catalog"].exists)
//    }
}


