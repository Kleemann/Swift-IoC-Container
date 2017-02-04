import Foundation

class Container {
    
    fileprivate static var registrations = [AnyHashable : () -> Any]()
    
    static func register<T>(_: T.Type, constructor: @escaping () -> Any) {
        let dependencyName = String(describing: T.self)
        registrations[dependencyName] = constructor
    }
    
    static func registerAsSingleton<T>(_: T.Type, constructor: @escaping () -> Any) {
        let dependencyName = String(describing: T.self)
        var instance: Any?
        let resolver: () -> Any = {
            if instance == nil {
                instance = constructor()
                return instance!
            } else {
                return instance!
            }
        }
        registrations[dependencyName] = resolver
    }
    
    //Weak may only be applied to class and class-bound types, not 'Any'
    static func registerWeakSingleton<T>(_: T.Type, constructor: @escaping () -> AnyObject) {
        let dependencyName = String(describing: T.self)
        var instance: AnyObject?
        instance = nil
        let resolver: () -> AnyObject = { [weak instance] in
            if let instance = instance {
                return instance
            } else {
                let newInstance = constructor()
                instance = newInstance
                return newInstance
            }
        }
        registrations[dependencyName] = resolver
    }
    
    static func resolve<T>(type: T.Type = T.self) -> T {
        let dependencyName = String(describing: T.self)
        guard let resolver = registrations[dependencyName] else {
            fatalError("No registration for type \(dependencyName)")
        }
        guard let result = resolver() as? T else {
            fatalError("Can't cast registration to type \(dependencyName)")
        }
        return result
    }
    
    static func remove<T>(type: T.Type) {
        let dependencyName = String(reflecting: T.self)
        registrations.removeValue(forKey: dependencyName)
    }
}
