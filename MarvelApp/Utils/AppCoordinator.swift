import UIKit

final class AppCoordinator: Coordinator {
    private static var window: UIWindow? = {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        return sceneDelegate?.window
    }()

    static func start() {
        startApp()
    }

    private static func startApp() {
        let navigation = UINavigationController()
        configureNavigation()

        let carListCoordinator = CharacterListCoordinator(navigation: navigation)
        carListCoordinator.start()

        window?.rootViewController = navigation
    }

    private static func configureNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.configureWithTransparentBackground()

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
