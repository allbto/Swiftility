//
//  UICollectionViewTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/31/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
import Nimble
@testable import Swiftility

class UICollectionViewTests: XCTestCase
{
//    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    let collectionVC = TestCollectionViewVC.instantiateFromStoryboard()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDequeueCell()
    {
        let collectionView = self.collectionVC.collectionView
        
        expect(collectionView).toNot(beNil())
        
        expect(collectionView!.registerCell(TestCollectionViewCell)).toNot(raiseException())
        
        expect(collectionView!.dequeueReusableCell(TestCollectionViewCell.self, forIndexPath: NSIndexPath(forRow: 0, inSection: 0))).to(beTruthy())
    }

//    func testDequeueView()
//    {
//        let collectionView = self.collectionVC.collectionView
//
//        expect(collectionView!.registerSupplementaryView(TestCollectionViewView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)).toNot(raiseException())
//        
//        expect(collectionView!.dequeueReusableSupplementaryView(kind: UICollectionElementKindSectionHeader, type: TestCollectionViewView.self, forIndexPath: NSIndexPath(forRow: 0, inSection: 0))).to(beTruthy())
//    }
}
