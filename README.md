[![CocoaPods Status](https://img.shields.io/cocoapods/v/Swiftility.svg?style=flat)](http://cocoapods.org/pods/Swiftility)
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

**async**
```swift
func async(queue: GCDQueue = .Default, closure: dispatch_block_t)
func async_main(closure: dispatch_block_t) // same as calling `async(.Main, closure: closure)`
 
async {
    // Asynchronous code
 
    async_main {
        // Main thread code
    }
}
```

**after**
```swift
func after(delay: Double, queue: GCDQueue = .Main, closure: dispatch_block_t)
 
after(2.5) {
    // Executed after 2.5 seconds
}
```
 
