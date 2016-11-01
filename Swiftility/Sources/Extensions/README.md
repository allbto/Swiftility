
# Extensions

### Timer

Closure usage of timer. Allows to use weak self, avoiding retain cycles.

```swift
Timer.scheduledTimer(timeInterval: 1, repeats: true) { [weak self] in
    // Code repeated every 1 second

    // Do something with weak self
}
```

#### TODO: Add All extensions
