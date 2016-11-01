[![CocoaPods Status](https://img.shields.io/cocoapods/v/Swiftility.svg?style=flat)](http://cocoapods.org/pods/Swiftility)
[![Build Status](https://travis-ci.org/allbto/iOS-Swiftility.svg?branch=master)](https://travis-ci.org/allbto/iOS-Swiftility)
[![License](https://img.shields.io/cocoapods/l/Swiftility.svg?style=flat)](http://cocoapods.org/pods/Swiftility)
[![Platform](https://img.shields.io/cocoapods/p/Swiftility.svg?style=flat)](http://cocoapods.org/pods/Swiftility)
[![Swift-2.2](http://img.shields.io/badge/Swift-2.2-blue.svg)]()

# Swiftility

Framework grouping utilities to use in various projects

## Installation
 
Swiftility is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "Swiftility"
```

## Usage

```swift
import Swiftility
```
 
# Features
 
* [Core](#core)
* [Type Safety](#type-safety)
* [Extensions](Swiftility/Sources/Extensions)

### MVVM

Checkout the [MVVM implementation example](MVVM.md) I wrote using Swiftility

# Core

### Dynamic

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
 
### Grand Central Dispatch

Convenience use of GCD methods

**async()**
```swift
async {
    // Asynchronous code
 
    async_main {
        // Main thread code
    }
}
```

**after()**
```swift
after(2.5) {
    // Executed after 2.5 seconds
}
```

**once()**
```swift
once("someToken") {
    // Executed only once for the given token
}
```

**debounce()**
```swift
let debouncedFunction = debounced(0.5) { someVarOrVoid in
    // Executed only every 0.5 seconds
}

debouncedFunction(someVarOrVoid)
```


# Type safety

### Storyboard

```swift
/// Define Storyboard names

extension UIStoryboard.Name
{
    static let settings = UIStoryboard.Name(name: "Settings")
}

/// Define your view controller built in the `Settings` storyboard
// "SettingsViewController" should be the identifier in the storyboard (same as class name)

class SettingsViewController: UIViewController, FromStoryboard
{
	static let storyboardName: UIStoryboard.Name = .settings
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

tableView.register(MyCell.self)

/// Later

let cell = tableView.dequeueReusableCell() as MyCell
```

### CollectionView

```swift
/// Define cell defined in "MyCell.xib"

class MyCell: UICollectionViewCell, FromNib { ... }

collectionView.register(MyCell.self)

/// Define custom view defined in "MyCustomView.xib"

class MyCustomView: UICollectionReusableView, FromNib { ... }

collectionView.register(MyCustomView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)

/// Later

let supView: MyCustomView = collectioView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, for: someIndexPath)

let cell = collectioView.dequeueReusableCell(for: someIndexPath) as MyCell
```

# Extensions

See [Extensions page](Swiftility/Sources/Extensions)
 
# Author

Allan Barbato, allan.barbato@gmail.com

# License

Swiftility is available under the MIT license. See the LICENSE file for more info.
