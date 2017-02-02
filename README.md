# Swift-IoC-Container
Simple IoC container for registering and resolving dependencies, written in Swift 3.0

## Usage

### Register dependencies
```swift
 Container.registerAsSingleton(APIManager.self) { NetworkManager(withProxy: AlamofireProxyImplementation()) }
```
### Resolve dependencies
```swift
let networkManager: APIManager = Container.resolve()
```
