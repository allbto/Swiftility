[![CocoaPods Status](https://img.shields.io/cocoapods/v/Swiftility.svg?style=flat)](http://cocoapods.org/pods/Swiftility)
[![Build Status](https://travis-ci.org/allbto/iOS-Swiftility.svg?branch=master)](https://travis-ci.org/allbto/iOS-Swiftility)
[![License](https://img.shields.io/cocoapods/l/Swiftility.svg?style=flat)](http://cocoapods.org/pods/Swiftility)
[![Platform](https://img.shields.io/cocoapods/p/Swiftility.svg?style=flat)](http://cocoapods.org/pods/Swiftility)
[![Swift-2.1](http://img.shields.io/badge/Swift-2.1-blue.svg)]()

# Swiftility

Framework grouping my utilities to use in various projects

## Installation
 
Swiftility is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "Swiftility"
```

## Usage

```swift
import Swiftility
```

## Type safe UIKit

### Storyboard

```swift
/// Define Storyboard convertible type

enum Storyboards: String, StoryboardConvertible {
	case Main, Settings, Explore

	var storyboardName: String {
        return self.rawValue
    }
}

/// Define your view controller built in the `Settings` storyboard
// "SettingsViewController" should be the identifier in the storyboard (same as class name)

class SettingsViewController: UIViewController, FromStoryboard {
	static let ownStoryboard = Storyboards.Settings
}

/// Now you can do this

let settingsVC = SettingsViewController.instantiateFromStoryboard()
```

### Nib

```swift
// "SettingsViewController.xib" should be the file containing SettingsViewController

class SettingsViewController: UIViewController, FromNib { ... }

// "MyView.xib" should be the file containing MyView

class MyView: UIView, FromNib { ... }

/// Now you can do this

let settingsVC = SettingsViewController.instantiateFromNib()

let myView = MyView.instantiateFromNib()
```

### TableView

```swift
/// Define cell defined in "MyCell.xib"

class MyCell: UITableViewCell, FromNib { ... }

// Register cell

tableView.registerCell(MyCell)

/// Later

let cell: MyCell = tableView.dequeueReusableCell(MyCell)
```

### CollectionView

```swift
/// Define cell defined in "MyCell.xib"

class MyCell: UICollectionViewCell, FromNib { ... }

collectionView.registerCell(MyCell)

/// Define custom view defined in "MyCustomView.xib"

class MyCustomView: UICollectionReusableView, FromNib { ... }

collectionView.registerSupplementaryView(MyCustomView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)

/// Later

let supView: MyCustomView = collectioView.dequeueReusableSupplementaryView(kind: UICollectionElementKindSectionHeader, forIndexPath: someIndexPath)

let cell: MyCell = collectioView.dequeueReusableCell(MyCell.self, forIndexPath: someIndexPath)
```

## Dynamic

Lightweight binding in Swift

```swift
struct Dynamic<T> {
	var value: T

	// ...

	init(_ value: T)

	// ...

	func bind(listener: T -> Void)

	// ...
}

/// Usage example

var email: Dynamic<String>("")

email.bind { value in
	print("Email is now: \(value)")
}

email.value = "allan@test.com"
// prints "Email is now: allan@test.com"
```
 
## Grand Central Dispatch

Convenience use of GCD queues

```swift
enum GCDQueue {
    case Main
    case High
    case Default
    case Low
    case Background
    case Custom(dispatch_queue_t)
}
```

**async()**
```swift
func async(queue: GCDQueue = .Default, closure: dispatch_block_t)
func async_main(closure: dispatch_block_t) // same as calling async(.Main, closure: closure)
 
async {
    // Asynchronous code
 
    async_main {
        // Main thread code
    }
}
```

**after()**
```swift
func after(delay: Double, queue: GCDQueue = .Main, closure: dispatch_block_t)
func delay(delay: Double, queue: GCDQueue = .Main, closure: dispatch_block_t) // Same as above
 
after(2.5) {
    // Executed after 2.5 seconds
}
```

## Weak

Container of weak variable

```swift
struct Weak<T: AnyObject> {
    weak var value : T?

    init (_ value: T)
}

/// Usage example

let arrayOfViewControllers = [Weak(vc1), Weak(vc2), Weak(vc3)]
let vc1View = arrayOfViewControllers[0].value?.view
```

## Weak Timer

```swift
class WeakTimer {
	static func scheduledTimerWithTimeInterval(timeInterval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, callback: () -> Void) -> NSTimer
}

// Usage example

WeakTimer.scheduledTimerWithTimeInterval(1, repeats: true) { [weak self] in
	// Code repeated every 1 second
	// Do something with weak self?
}
```
 
## Author

Allan Barbato, allan.barbato@gmail.com

## License

Swiftility is available under the MIT license. See the LICENSE file for more info.
