# Swift-IoC-Container
Simple IoC container for registering and resolving dependencies, written in Swift 3.0

## Usage

### Register dependencies
```swift
 Container.registerAsSingleton(APIManager.self) { NetworkManager(withProxy: AlamofireProxyImplementation()) }
```
For networking abstraction see [Swift-Network-Abstraction](https://github.com/Kleemann/Swift-Network-Abstraction)
### Resolve dependencies
```swift
let networkManager: APIManager = Container.resolve()
```
