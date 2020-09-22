import UIKit

class CharacterCell: UITableViewCell {
    private var characterThumb = UIImageView()
    private var characterName = UILabel()
    private var characterStatus = UILabel()
    private var characterSpicie = UILabel()
    private var characterOrigin = UILabel()
    private var imageCache = NSCache<NSString, UIImage>()
    private var imageService = ImageService()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(characterThumb)
        addSubview(characterName)
        addSubview(characterStatus)
        addSubview(characterSpicie)
        addSubview(characterOrigin)
        
        configureCell()
        configuraCharacterThumb()
        configureCharacterLabels()
        setImageConstrains()
        setNameConstrains()
        setStatusConstrains()
        setOriginConstrains()
        setSpicieConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCharacter(character: Character) {
        if let safeName = character.name {
            self.setName(name: safeName)
        } else {
            self.setName(name: "")
        }
        
        if let safeStatus = character.status {
            if let safeGender = character.gender {
                self.setStatus(status: safeStatus + " • " + safeGender)
            } else {
                self.setStatus(status: safeStatus)
            }
        } else {
            self.setStatus(status: "")
        }
        
        if let safeSpicie = character.species {
            self.setSpicie(spicie: "Espécie: " + safeSpicie)
        } else {
            self.setSpicie(spicie: "")
        }
        
        if let safeOrigin = character.origin.name {
            self.setOrigin(origin: "Origem: " + safeOrigin)
        } else {
            self.setOrigin(origin: "")
        }
        
        if let safeUrl = character.image {
            self.setAsyncImage(url: safeUrl)
        }
    }
    
    func setName(name: String) {
        self.characterName.text = name
    }
    
    func setStatus(status: String) {
        self.characterStatus.text = status
    }
    
    func setSpicie(spicie: String) {
        self.characterSpicie.text = spicie
    }
    
    func setOrigin(origin: String) {
        self.characterOrigin.text = origin
    }
    
    func setAsyncImage(url: String) {
        let requestURL = URL(string: url)
        self.characterThumb.image = nil
        if let imageFromCache = self.imageCache.object(forKey: url as NSString) {
            self.characterThumb.image = imageFromCache
            return
        }
        if imageService.dataTask != nil {
            imageService.dataTask?.cancel()
        }
        imageService.asyncDownloadImage(requestURL) { (image, urlRequested) in
            guard let safeImage = image else {
                return
            }
            self.imageCache.setObject(safeImage, forKey: url as NSString)
            if urlRequested == url {
                self.characterThumb.image = image
            }
        }
    }
    
    func configureCell() {
        backgroundColor = UIColor(red: 60/255, green: 62/255, blue: 68/255, alpha: 1)
    }
    
    func configuraCharacterThumb() {
        characterThumb.layer.cornerRadius = 10
        characterThumb.clipsToBounds = true
    }
    
    func configureCharacterLabels() {
        characterName.font = UIFont.boldSystemFont(ofSize: 20)
        characterName.adjustsFontSizeToFitWidth = false
        characterName.lineBreakMode = .byTruncatingTail
        characterName.adjustsFontSizeToFitWidth = true
        characterName.textColor = .white
        
        characterStatus.font = UIFont.systemFont(ofSize: 13, weight: .light)
        characterStatus.adjustsFontSizeToFitWidth = false
        characterStatus.lineBreakMode = .byTruncatingTail
        characterStatus.adjustsFontSizeToFitWidth = true
        characterStatus.textColor = .white
        
        characterSpicie.font = UIFont.systemFont(ofSize: 13, weight: .light)
        characterSpicie.adjustsFontSizeToFitWidth = false
        characterSpicie.lineBreakMode = .byTruncatingTail
        characterSpicie.adjustsFontSizeToFitWidth = true
        characterSpicie.textColor = .white
        
        characterOrigin.font = UIFont.systemFont(ofSize: 13, weight: .light)
        characterOrigin.adjustsFontSizeToFitWidth = false
        characterOrigin.lineBreakMode = .byTruncatingTail
        characterOrigin.adjustsFontSizeToFitWidth = true
        characterOrigin.textColor = .white
    }
    
    func setImageConstrains() {
        characterThumb.translatesAutoresizingMaskIntoConstraints = false
        characterThumb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        characterThumb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        characterThumb.heightAnchor.constraint(equalToConstant: 80).isActive = true
        characterThumb.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setNameConstrains() {
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterName.leadingAnchor.constraint(equalTo: characterThumb.trailingAnchor, constant: 10).isActive = true
        characterName.topAnchor.constraint(equalTo: characterThumb.topAnchor).isActive = true
        characterName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setStatusConstrains() {
        characterStatus.translatesAutoresizingMaskIntoConstraints = false
        characterStatus.leadingAnchor.constraint(equalTo: characterName.leadingAnchor).isActive = true
        characterStatus.topAnchor.constraint(equalTo: characterName.bottomAnchor).isActive = true
        characterStatus.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setSpicieConstrains() {
        characterSpicie.translatesAutoresizingMaskIntoConstraints = false
        characterSpicie.leadingAnchor.constraint(equalTo: characterName.leadingAnchor).isActive = true
        characterSpicie.topAnchor.constraint(equalTo: characterStatus.bottomAnchor).isActive = true
        characterSpicie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setOriginConstrains() {
        characterOrigin.translatesAutoresizingMaskIntoConstraints = false
        characterOrigin.leadingAnchor.constraint(equalTo: characterName.leadingAnchor).isActive = true
        characterOrigin.topAnchor.constraint(equalTo: characterSpicie.bottomAnchor).isActive = true
        characterOrigin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
