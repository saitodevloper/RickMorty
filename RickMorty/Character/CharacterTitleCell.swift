import UIKit

class CharacterTitleCell: UITableViewCell {
    var background = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let image = UIImage(named: "Title") {
            background.image = image
        }
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.heightAnchor.constraint(equalToConstant: 90).isActive = true
        background.widthAnchor.constraint(equalToConstant: 200).isActive = true
        background.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
