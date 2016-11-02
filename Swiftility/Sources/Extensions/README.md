
# Extensions

## UIKit

#### UIColor

Init color with hexadecimal value or real RGB (no more XX/255)

```swift
UIColor("#FF00FF")
UIColor(0xFF00FF)
UIColor(realRed: 255, green: 0, blue: 255)
```

Get color hexadecimal string

```swift
UIColor.white.rgbValue  -> "#FFFFFF"
UIColor.clear.rgbaValue -> "#FFFFFF00"
```

Adjust color

```swift
func lighter(_ amount: CGFloat) -> UIColor
func darker(_ amount : CGFloat) -> UIColor
func adjust(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
```

#### UIViewController

Keyboard notifications handling

```swift
let observers = self.observeKeyboardChanges { keyboardSize, notification in

    // Update some constraints
    
    // Call this to animate with the notification animation duration and options
    self.animate(
        withKeyboardNotification: notification
        animations: {
            // Call layoutIfNeeded() or own animations
        }
    )
}
```

Show UIAlertController with message and title

```swift
self.alert("Something's wrong", title: "Oups!")
self.ask("Are you sure you want to delete this?", title: "Really?") {
    // Ok action handling
}
```

#### Spacing

UITextView and UILabel methods to add character or line spacing to text

```swift
func setTextWithSpacing(_ text: String?, characterSpacing: CGFloat, lineSpacing: CGFloat, ...)
```

#### UIDevice

```swift
var version: Float // .systemVersion as float
var isPhone: Bool 
var isPad: Bool
var isRetina: Bool
var size: CGSize // UIScreen size
```

#### UIImage

Apple's UIImage Effects

```swift
func applyingLightEffect() -> UIImage?
func applyingExtraLightEffect() -> UIImage?
func applyingDarkEffect() -> UIImage?
func applyingTintEffect(with color: UIColor) -> UIImage?
func applyingBlur(withRadius radius: CGFloat, ...) -> UIImage?
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
