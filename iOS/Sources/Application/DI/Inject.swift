import Swinject

@propertyWrapper
final class Inject<T>{
    let wrappedValue: T
    init(){
        wrappedValue = AppDelegate.container.resolve(T.self)!
    }
}

