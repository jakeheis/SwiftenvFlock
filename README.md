# SwiftenvFlock
Integration of [Swiftenv](https://github.com/kylef/swiftenv) into [Flock](https://github.com/jakeheis/Flock) deployments
# Installation
Add these lines to `config/deploy/FlockDependencies.json`:
```
"dependencies" : [
       ...
       {
           "url" : "https://github.com/jakeheis/SwiftenvFlock",
           "version": "0.0.1"
       }
]
```
In your `Flockfile` add:
```swift
import Flock
import SwiftenvFlock

...

Flock.use(Flock.Deploy)
Flock.use(Flock.Swiftenv)
```
# Tasks
```bash
flock swiftenv:swift               # Hooks .before("deploy:build")
flock swiftenv:install-swiftenv    # Invoked by swiftenv:swift if need be
```
`SwiftenvFlock` hooks into the deploy process automatically, so you should never have to call these tasks directly.
# Configuration
If you have a `.swift-version` file in your project directory, you should not use this configuration variable.
```swift
public extension Config {
    static var swiftVersion: String? = nil
}
```
