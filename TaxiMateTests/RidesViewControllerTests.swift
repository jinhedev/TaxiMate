//
//  MainRidesCellTests.swift
//  HSDTests
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import XCTest
@testable import TaxiMate

class RidesViewControllerTests: XCTestCase {

    var sut: RidesViewController!

    func testUICollectionViewDelegateForMemoryReference() {
        XCTAssertTrue(sut.collectionView.delegate === sut, "incorrect pointer to memory location")
    }

    func testUICollectionViewDataSourceForMemoryReference() {
        XCTAssertTrue(sut.collectionView.dataSource === sut, "incorrect pointer to memory location")
    }

    func testUICollectionViewDelegateForNil() {
        XCTAssertNotNil(sut.collectionView.delegate)
    }

    func testUICollectionViewDataSourceForNil() {
        XCTAssertNotNil(sut.collectionView.dataSource)
    }
    
    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "RidesTab", bundle: nil).instantiateViewController(withIdentifier: RidesViewController.storyboard_id) as! RidesViewController
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
}
