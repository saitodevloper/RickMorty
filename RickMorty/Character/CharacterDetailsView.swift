import UIKit

class CharacterDetailsView: ViewSetup {
    private var poster = UIImageView()
    private var name = UILabel()
    private var details = UILabel()
    private var button = UIButton(type: .system)
    
    private var character: Character? = nil
    var characterId: Int? = nil
    private var imageCache = NSCache<NSString, UIImage>()
    private var imageService = ImageService()
    
    func callApi(characterId: Int?) {
        if let id = characterId {
            self.characterId = characterId
            ApiService
                .instance
                .prepareGet(withUrl: "https://rickandmortyapi.com/api/character/" + String(id))
                .execute() { data, url in
                    self.setViewCharacter(chacter: Character(jsonDict: data as! [String: Any]))
            }
        }
    }
    
    func setViewCharacter(chacter: Character) {
        self.character = chacter
        if let image = chacter.image {
            setAsyncImage(url: image)
        }
        if let name = chacter.name {
            setNameCharacter(name: name)
        }
        if let status = chacter.status {
            setDetailsCharacter(details: status)
            if let gender = chacter.gender {
                setDetailsCharacter(details: status + " • " + gender)
                if let origin = chacter.origin.name {
                    setDetailsCharacter(details: status + " • " + gender + " • " + origin)
                }
            }
        }
    }
    
    func setNameCharacter(name: String) {
        self.name.text = name
    }
    
    func setDetailsCharacter(details: String) {
        self.details.text = details
    }
    
    func setButtonClick() {
        self.button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    @objc func onClick() {
        if let character = character {
            CodaService.save(character: character)
        }
    }
    
    func viewSetUp(to superView: UIView) {
        superView.addSubview(poster)
        superView.addSubview(name)
        superView.addSubview(details)
        superView.addSubview(button)
        
        setImageConstrains(superView: superView)
        setNameConstrains(superView: superView)
        setDetailsContrains(superView: superView)
        setButtonConstrains(superView: superView)
        setButtonClick()
    }
    
    func setImageConstrains(superView: UIView) {
        let guide = superView.safeAreaLayoutGuide
        poster.layer.borderWidth = 1
        poster.layer.masksToBounds = false
        poster.layer.borderColor = UIColor.white.cgColor
        poster.layer.cornerRadius = poster.frame.height/2
        poster.layer.cornerRadius = 80
        poster.clipsToBounds = true
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        poster.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
        poster.heightAnchor.constraint(equalToConstant: 160).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func setNameConstrains(superView: UIView) {
        name.font = UIFont.boldSystemFont(ofSize: 25)
        name.adjustsFontSizeToFitWidth = false
        name.lineBreakMode = .byTruncatingTail
        name.textAlignment = .center
        name.adjustsFontSizeToFitWidth = true
        name.textColor = .white
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        name.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 15).isActive = true
        name.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
    }
    
    func setDetailsContrains(superView: UIView) {
        details.font = UIFont.systemFont(ofSize: 16, weight: .light)
        details.adjustsFontSizeToFitWidth = false
        details.lineBreakMode = .byTruncatingTail
        details.textAlignment = .center
        details.adjustsFontSizeToFitWidth = true
        details.textColor = .white
        
        details.translatesAutoresizingMaskIntoConstraints = false
        details.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        details.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        details.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        details.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
    }
    
    func setButtonConstrains(superView: UIView) {
        button.setTitle("Salvar", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 20, weight: .light)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: details.bottomAnchor, constant: 4).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func setAsyncImage(url: String) {
        let requestURL = URL(string: url)
        self.poster.image = nil
        if let imageFromCache = self.imageCache.object(forKey: url as NSString) {
            self.poster.image = imageFromCache
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
                self.poster.image = image
            }
        }
    }
}
