import UIKit

class MainScreenNavigator: AppNavigator {
    func navigator() -> UINavigationController {
        let mainScreen = CharacterScreen()
        let navController = UINavigationController(rootViewController: mainScreen)
        return navController
    }
}
