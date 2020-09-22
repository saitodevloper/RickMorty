import UIKit

class CharacterFavoriteScreen: UIViewController, ClickDelegate {
    private var _view: ViewSetup
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let temp = CharacterFavoriteView()
        self._view = temp
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        temp.setClickDelegate(clickDelegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.viewSetUp(to: view)
    }
    
    func clicked(obj: Any) {
        if obj is Character {
            let screen = CharacterDetailsScreen(characterId: (obj as! Character).id ?? -1)
            self.navigationController?.pushViewController(screen, animated: false)
        }
    }
}
