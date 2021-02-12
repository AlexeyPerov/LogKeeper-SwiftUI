import SwiftUI
import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let container: Container = {
        let container = Container()
        container.register(LogsRepository.self) { _ in FirebaseLogsRepository() }.inObjectScope(.container)
        return container
    }()
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        let logsRepository = container.resolve(LogsRepository.self)
        logsRepository?.initialize()
        
        if let windowScene = scene as? UIWindowScene {
            print("Creating AppState")
            let store = AppState(repository: logsRepository!)
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: HomeView()
                                                                .environmentObject(store))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_: UIScene) {
    }
    
    func sceneDidBecomeActive(_: UIScene) {
    }
    
    func sceneWillResignActive(_: UIScene) {
    }
    
    func sceneWillEnterForeground(_: UIScene) {
    }
    
    func sceneDidEnterBackground(_: UIScene) {
    }
}
