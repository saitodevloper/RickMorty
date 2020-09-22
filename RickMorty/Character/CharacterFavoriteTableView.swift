import UIKit

class CharacterFavoriteTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    internal var _rowHeight: CGFloat = 100
    internal var ID1 = "CharacterIDCell"
    internal var delegateClick: ClickDelegate? = nil
    
    internal var nextRequest: String = "https://rickandmortyapi.com/api/character"
    internal var characters: [Character] = []
    
    func setup() -> CharacterFavoriteTableView {
        nextPage()
        self.delegate = self
        self.dataSource = self
        self.register(CharacterCell.self, forCellReuseIdentifier: ID1)
        rowHeight = _rowHeight
        return self
    }
    
    func nextPage() {
        self.characters = CodaService.retrive()
    }
    
    func setDelegateClick(delegateClick: ClickDelegate) -> CharacterFavoriteTableView {
        self.delegateClick = delegateClick
        return self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID1) as! CharacterCell
        let character = self.characters[indexPath.row]
        cell.setCharacter(character: character)
        return cell
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

