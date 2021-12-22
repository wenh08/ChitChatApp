 
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)

    let menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
    let navigationController = UINavigationController(rootViewController: menuViewController)

    let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = UIColor(
        red: 0.05,
        green: 0.36,
        blue: 0.54,
        alpha: 1.00
      )
      appearance.titleTextAttributes = [
          .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
          .foregroundColor: UIColor.white,
          ]
          
      navigationController.navigationBar.standardAppearance = appearance
      navigationController.navigationBar.scrollEdgeAppearance = appearance
      navigationController.navigationBar.tintColor = .white
      
   window.rootViewController = navigationController

    self.window = window
    window.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
  
  }

  func sceneWillResignActive(_ scene: UIScene) {
   
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
   
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    
  }
}
