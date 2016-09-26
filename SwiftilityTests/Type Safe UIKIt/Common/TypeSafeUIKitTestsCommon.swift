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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
}

class TestCollectionViewVC: UICollectionViewController, FromStoryboard
{
    static let ownStoryboard: StoryboardConvertible = StoryboardsTests.MainStoryboard
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
    }
}

class TestViewModelVC: UIViewController, ViewModelController
{
    var viewModel: TestViewModel!
}

class TestViewModel
{
    
}

// MARK: - View

class TestView: UIView {}

// MARK: - Table view

class TestCell: UITableViewCell, FromNib
{
    static var ownNib: NibConvertible {
        return NibContainer(String(describing: self), bundle: Bundle(for: StoryboardTests.self))
    }
}

class TestNonExistingCell: UITableViewCell, FromNib {}

class TestCellClass: UITableViewCell {}

// MARK: - Collection view

class TestCollectionViewStoryboardCell: UICollectionViewCell {}

class TestCollectionViewCell: UICollectionViewCell, FromNib
{
    static var ownNib: NibConvertible {
        return NibContainer(String(describing: self), bundle: Bundle(for: StoryboardTests.self))
    }
}

class TestNonExistingCollectionViewCell: UICollectionViewCell, FromNib {}

class TestCollectionViewCellClass: UICollectionViewCell {}

class TestCollectionViewView: UICollectionReusableView, FromNib
{
    static var ownNib: NibConvertible {
        return NibContainer(String(describing: self), bundle: Bundle(for: StoryboardTests.self))
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
    
    var bundle: Bundle? {
        return Bundle(for: StoryboardTests.self)
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
    
    var bundle: Bundle? {
        return Bundle(for: StoryboardTests.self)
    }
}

