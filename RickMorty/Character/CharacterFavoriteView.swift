import UIKit

class CharacterFavoriteView: ViewSetup, ClickDelegate {
    private var clickDelegate: ClickDelegate? = nil
    
    func clicked(obj: Any) {
        self.clickDelegate?.clicked(obj: obj)
    }
    
    func setClickDelegate(clickDelegate: ClickDelegate) {
        self.clickDelegate = clickDelegate
    }
    
    lazy var _tableView: UITableView = {
        return CharacterFavoriteTableView().setDelegateClick(delegateClick: self).setup()
    }()
    
    func viewSetUp(to parent: UIView) {
        parent.addSubview(_tableView)
        _tableView.pin(to: parent)
    }
}
