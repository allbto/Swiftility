//
//  TypeSafeUIKitTestsCommon.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/31/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation
import UIKit
@testable import Swiftility

// MARK: - View Controller

class TestVC: UIViewController, FromStoryboard
{
    static let ownStoryboard: StoryboardConvertible = StoryboardsTests.MainStoryboard
}

class TestNonExistingVC: UIViewController {}

class TestTableVC: UITableViewController, FromStoryboard
{
    static let ownStoryboard: StoryboardConvertible = StoryboardsTests.MainStoryboard
}

class TestCollectionViewVC: UICollectionViewController, FromStoryboard
{
    static let ownStoryboard: StoryboardConvertible = StoryboardsTests.MainStoryboard
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
}

// MARK: - View

class TestView: UIView {}

// MARK: - Table view

class TestCell: UITableViewCell, FromNib
{
    static var nib: NibConvertible {
        return NibContainer(String(self), bundle: NSBundle(forClass: StoryboardTests.self))
    }
}

class TestNonExistingCell: UITableViewCell, FromNib {}

// MARK: - Collection view

class TestCollectionViewCell: UICollectionViewCell, FromNib
{
    static var nib: NibConvertible {
        return NibContainer(String(self), bundle: NSBundle(forClass: StoryboardTests.self))
    }
}

class TestNonExistingCollectionViewCell: UICollectionViewCell, FromNib {}

class TestCollectionViewView: UICollectionReusableView, FromNib
{
    static var nib: NibConvertible {
        return NibContainer(String(self), bundle: NSBundle(forClass: StoryboardTests.self))
    }
}

// MARK: - Storyboard

enum StoryboardsDefault: String, StoryboardConvertible
{
    case MainStoryboard
    
    var storyboardName: String {
        return self.rawValue
    }
}

enum StoryboardsTests: String, StoryboardConvertible
{
    case MainStoryboard
    
    var storyboardName: String {
        return self.rawValue
    }
    
    var bundle: NSBundle? {
        return NSBundle(forClass: StoryboardTests.self)
    }
}

// MARK: - Nib

enum NibsDefault: String, NibConvertible
{
    case TestCell, TestCollectionViewCell
    
    var nibName: String {
        return self.rawValue
    }
}

enum NibsTests: String, NibConvertible
{
    case TestCell, TestCollectionViewCell
    
    var nibName: String {
        return self.rawValue
    }
    
    var bundle: NSBundle? {
        return NSBundle(forClass: StoryboardTests.self)
    }
}

