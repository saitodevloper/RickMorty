import UIKit

class CharacterDetailsScreen: UIViewController, ClickDelegate {
    private var _view: ViewSetup
    var characterId: Int? = nil
    
    init(characterId: Int) {
        self.characterId = characterId
        let screenView = CharacterDetailsView()
        self._view = screenView
        super.init(nibName: nil, bundle: nil)
        screenView.callApi(characterId: self.characterId)
    }
    
    @objc func onTouch(sender : UIButton) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 60/255, green: 62/255, blue: 68/255, alpha: 1)
        _view.viewSetUp(to: view)
        guard characterId != nil else {
            _ = navigationController?.popToRootViewController(animated: false)
            let alert = UIAlertController(title: "Erro!", message: "Não foi possível carregar personagem", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func clicked<UIView>(obj: UIView) {}
}
