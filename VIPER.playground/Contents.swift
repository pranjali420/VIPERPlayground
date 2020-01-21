import UIKit

protocol Router: class {
    func presentScreen(for name: String)
}

protocol View: class {
    func show(message: String)
}

protocol Presenter: class {
    func arrive()
    func wantsToContinue()
}

protocol Interactor: class {
    func arrived()
    func wantsToContinue()
}

protocol Output: class {
    func welcome(_ name: String)
    func wantsToShowScreen(for name: String)
}

// MARK: Entity
struct Entity {
    let name: String
}

// MARK: Router
class ARouter: Router {
    let closure: ((String) -> Void)
    
    init(closure: @escaping ((String) -> Void)) {
        self.closure = closure
    }
    
    func presentScreen(for name: String) {
        closure(name)
    }
}

// MARK: View
class AView: View {
    let presenter: Presenter
    
    func comeOnScreen() {
        presenter.arrive()
    }
    
    func proceed() {
        presenter.wantsToContinue()
    }
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    func show(message: String) {
        print(message)
    }
}

// MARK: Presenter
class APresenter: Presenter, Output {
    let router: Router
    let interactor: Interactor
    weak var view: View?
    
    init(router: Router, interactor: Interactor) {
        self.router = router
        self.interactor = interactor
    }
    
    func arrive() {
        interactor.arrived()
    }
    
    func wantsToContinue() {
        interactor.wantsToContinue()
    }
    
    func welcome(_ name: String) {
        view?.show(message: "Hello, \(name), and welcome to your profile!")
    }
    
    func wantsToShowScreen(for name: String) {
        router.presentScreen(for: name)
    }
}

// MARK: Interactor
class AInteractor: Interactor {
    weak var output: Output?
    
    let entity: Entity
    
    init(entity: Entity) {
        self.entity = entity
    }
    
    func arrived() {
        output?.welcome(entity.name)
    }
    
    func wantsToContinue() {
        output?.wantsToShowScreen(for: entity.name)
    }
}



let entity = Entity(name: "Taylor Swift")
let interactor = AInteractor(entity: entity)
let router = ARouter {
    print("I am the Router outreach and the name I got is \($0)")
}
let presenter = APresenter(router: router, interactor: interactor)
let view = AView(presenter: presenter)
presenter.view = view

interactor.output = presenter

view.comeOnScreen()

view.proceed()
