import UIKit

class CharacterTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    internal var _rowHeight: CGFloat = 100
    internal var ID1 = "CharacterIDCell"
    internal var ID2 = "CharacterIDTtileCell"
    internal var delegateClick: ClickDelegate? = nil
    
    internal var nextRequest: String = "https://rickandmortyapi.com/api/character"
    internal var characters: [Character] = []
    
    func setup() -> CharacterTableView {
        nextPage()
        self.delegate = self
        self.dataSource = self
        self.register(CharacterCell.self, forCellReuseIdentifier: ID1)
        self.register(CharacterTitleCell.self, forCellReuseIdentifier: ID2)
        rowHeight = _rowHeight
        return self
    }
    
    func nextPage() {
        ApiService
            .instance
            .prepareGet(withUrl: nextRequest)
            .execute() { data, next in
                self.nextRequest = next ?? "https://rickandmortyapi.com/api/character"
                let array = data as! [[String: Any]]
                for result: [String: Any] in array {
                    self.characters.append(Character(jsonDict: result))
                }
                self.reloadData()
        }
    }
    
    func setDelegateClick(delegateClick: ClickDelegate) -> CharacterTableView {
        self.delegateClick = delegateClick
        return self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ID2) as! CharacterTitleCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ID1) as! CharacterCell
            let character = self.characters[indexPath.row - 1]
            cell.setCharacter(character: character)
            return cell
        }
    }
    
    func setClick(delegateTo delegateClick: ClickDelegate) {
        self.delegateClick = delegateClick
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row - 1 >= 0 {
            let character = characters[indexPath.row - 1]
            self.delegateClick?.clicked(obj: character)
        } else {
            self.delegateClick?.clicked(obj: [String: Any]())
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 5 == characters.count {
            nextPage()
        }
    }
}
