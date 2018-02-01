# SwiftHighResolutionTimer

This package allows for simple timing. It tells you how many seconds have elapsed since
the timer was set with very high accuracy.

## Example

```swift3
let timer = HighResolutionTimer()
// Set the timer.
timer.mark()

// Do something.

print("\(timer.check()) seconds elapsed.")
```