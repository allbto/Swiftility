
# Extensions

## Swift

#### String

```swift
"Hello!".length                 -> 6
"Hello!"[0]                     -> "H"
"Hello!"[0 ..< 3]               -> "Hel"

"     Hello!     ".trimmed()    -> "Hello!"
"Hello!".truncated(3)           -> "Hel"
"Hello World!".words            -> ["Hello", "World"]

"allan@test.com".isValidEmail   -> true
"allan.com".isValidEmail        -> false

"My Name&urlInjection=true".urlEncoded() -> "My%20Name%26urlInjection%3Dtrue"
```

#### Array

```swift
[1, 2, 3].get(0)  -> Optional(1)
[1, 2, 3].get(42) -> nil

var a = ["Hello", "World", "123"]
a.remove("123")
a -> ["Hello", "World"]

// Map + remove nil values. Doesn't flatten if multiple level of array like flatMap does
["Hello", "World", nil, "Sup?", nil].optionalMap { $0?.uppercased() } -> ["HELLO", "WORLD", "SUP?"]
```

## UIKit

#### UIView

AutoLayout Helpers

```swift
let myView = UIView()

myView.autoAttach(to: superview) {
    $0.autoPin(.centerX)
    $0.autoPin(.top, constant: 25)
    $0.autoPin([.width, .height], toItem: nil, constant: 50)
}

==

let myView = UIView()

myView.translatesAutoresizingMaskIntoConstraints = false
superview.addSubview(myView)
superview.addConstraints([
    NSLayoutConstraint(item: myView, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0),
    NSLayoutConstraint(item: myView, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 25),
    NSLayoutConstraint(item: myView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
    NSLayoutConstraint(item: myView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
])
```

[More Info](UIKit/UIView/UIViewAutoLayoutExtensions.swift)

#### UIColor

Init color with hexadecimal value or real RGB (no more XX/255)

```swift
UIColor("#FF00FF")
UIColor(0xFF00FF)
UIColor(realRed: 255, green: 0, blue: 255)

UIColor.white.rgbValue  -> "FFFFFF"
UIColor.clear.rgbaValue -> "FFFFFF00"

UIColor.white.brightness -> 1
UIColor.black.brightness -> 0
```

Adjust color

```swift
func lighter(_ amount: CGFloat) -> UIColor
func darker(_ amount: CGFloat) -> UIColor
func adjust(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
```

#### UIViewController

Keyboard notifications handling

```swift
let observers = self.observeKeyboardChanges { keyboardSize, notification in

    // Update some constraints
    
    // Call this to animate with the notification animation duration and options
    self.animate(
        withKeyboardNotification: notification,
        animations: {
            // Call layoutIfNeeded() or own animations
        }
    )
}
```

Show UIAlertController with message and title

```swift
self.alert("Something's wrong", title: "Oups!")
self.ask(
    "Are you sure you want to delete this?",
    title: "Really?",
    okTitle: "Sure!",
    cancelTitle: "Nah",
    okHandler: { action in
        // Ok action handling
    }
)
```

#### Spacing

UITextView and UILabel methods to add character or line spacing to text

```swift
func setTextWithSpacing(_ text: String?, characterSpacing: CGFloat, lineSpacing: CGFloat, ...)
```

#### UIDevice

```swift
UIDevice.current.version // .systemVersion as Float
UIDevice.current.isPhone
UIDevice.current.isPad
UIDevice.current.isRetina
UIDevice.current.size // UIScreen size
```

#### UIImage

Apple's UIImage Effects

```swift
func applyingLightEffect() -> UIImage?
func applyingExtraLightEffect() -> UIImage?
func applyingDarkEffect() -> UIImage?
func applyingTintEffect(with color: UIColor) -> UIImage?
func applyingBlur(withRadius radius: CGFloat, tintColor: UIColor?, ...) -> UIImage?
```

## Foundation

#### Date

```swift
func date(from: String, format: String, ...)
var relativeValue: String // Ex: "Today, 15:30"
```

#### NotificationCenter

Array manipulation of NotificationCenter observers

```swift
func addObserver(withNames names: [NSNotification.Name], ...)
func removeObservers()
```

#### Timer

Closure usage of timer. Allows to use weak self, avoiding retain cycles

```swift
Timer.scheduledTimer(timeInterval: 1, repeats: true) { [weak self] in
    // Code repeated every 1 second
    // Do something with weak self
}
```

### TODO: Add rest of extensions
