import UIKit
import Kingfisher

class AirlineDetailViewController: UIViewController {
    @IBOutlet weak var airlineImageView: UIImageView!
    @IBOutlet weak var airlineName: UILabel!
    @IBOutlet weak var icaoLabel: UILabel!
    @IBOutlet weak var iataLabel: UILabel!
    @IBOutlet weak var fleetDescriptionLabel: UILabel!
    @IBOutlet weak var airlineThemeImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var airline: Airline?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange(_:)), name: .themeDidChange, object: nil)
        updateFavoriteButtonAppearance()

    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeDidChange, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyCurrentTheme()
        updateFavoriteButtonAppearance()
    }
    func configureView() {
        guard let airline = airline else { return }
        airlineName.text = airline.name
        icaoLabel.text = "ICAO: \(airline.icao)"
        iataLabel.text = "IATA: \(airline.iata)"
        fleetDescriptionLabel.text = "Fleet: \(formatFleetDescription(airline.fleet))"

        if let url = URL(string: airline.logoURL ?? "") {
            airlineImageView.kf.setImage(with: url)
        } else {
            airlineImageView.image = UIImage(named: "placeholder")
        }
        updateFavoriteButtonAppearance()

    }
    
    @objc private func themeDidChange(_ notification: Notification) {
        guard let isDarkTheme = notification.userInfo?["isDarkTheme"] as? Bool else { return }
        applyThemeToImage(isDarkTheme: isDarkTheme)
    }
    private func applyCurrentTheme() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        applyThemeToImage(isDarkTheme: isDarkTheme)
    }
    private func applyThemeToImage(isDarkTheme: Bool) {
        if let image = airlineImageView.image {
            if isDarkTheme {
                airlineThemeImageView.image = image.withRenderingMode(.alwaysTemplate)
                airlineThemeImageView.tintColor = .lightGray
            } else {
                airlineThemeImageView.image = UIImage(named: "horizont")
            }
        }
    }
    
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard var airline = airline else { return }

        if FavoritesManager.shared.isFavorite(airline) {
            FavoritesManager.shared.removeFavorite(airline)
            airline.isFavorite = false
        } else {
            FavoritesManager.shared.addFavorite(airline)
            airline.isFavorite = true
        }

        updateFavoriteButtonAppearance()
    }
    private func updateFavoriteButtonAppearance() {
        if let airline = airline, FavoritesManager.shared.isFavorite(airline) {
            favoriteButton.tintColor = .red
        } else {
            favoriteButton.tintColor = .systemBlue
        }
    }
    func formatFleetDescription(_ fleet: Fleet) -> String {
        var description = ""

        if let A20N = fleet.A20N, A20N > 0 { description += "A20N: \(A20N)\n" }
        if let A21N = fleet.A21N, A21N > 0 { description += "A21N: \(A21N)\n" }
        if let A320 = fleet.A320, A320 > 0 { description += "A320: \(A320)\n" }
        if let A321 = fleet.A321, A321 > 0 { description += "A321: \(A321)\n" }
        if let B752 = fleet.B752, B752 > 0 { description += "B752: \(B752)\n" }
        if let B763 = fleet.B763, B763 > 0 { description += "B763: \(B763)\n" }
        if let E290 = fleet.E290, E290 > 0 { description += "E290: \(E290)\n" }
        if let B738 = fleet.B738, B738 > 0 { description += "B738: \(B738)\n" }
        if let B744 = fleet.B744, B744 > 0 { description += "B744: \(B744)\n" }
        if let B772 = fleet.B772, B772 > 0 { description += "B772: \(B772)\n" }
        if let B773 = fleet.B773, B773 > 0 { description += "B773: \(B773)\n" }
        if let B77W = fleet.B77W, B77W > 0 { description += "B77W: \(B77W)\n" }
        if let B78X = fleet.B78X, B78X > 0 { description += "B78X: \(B78X)\n" }
        if let IL76 = fleet.IL76, IL76 > 0 { description += "IL76: \(IL76)\n" }
        if let LJ75 = fleet.LJ75, LJ75 > 0 { description += "LJ75: \(LJ75)\n" }
        if let B350 = fleet.B350, B350 > 0 { description += "B350: \(B350)\n" }
        if let CL30 = fleet.CL30, CL30 > 0 { description += "CL30: \(CL30)\n" }
        if let J328 = fleet.J328, J328 > 0 { description += "J328: \(J328)\n" }
        if let LJ45 = fleet.LJ45, LJ45 > 0 { description += "LJ45: \(LJ45)\n" }
        if let PC12 = fleet.PC12, PC12 > 0 { description += "PC12: \(PC12)\n" }
        if let GLF5 = fleet.GLF5, GLF5 > 0 { description += "GLF5: \(GLF5)\n" }
        if let LJ60 = fleet.LJ60, LJ60 > 0 { description += "LJ60: \(LJ60)\n" }
        if let AN12 = fleet.AN12, AN12 > 0 { description += "AN12: \(AN12)\n" }
        if let B733 = fleet.B733, B733 > 0 { description += "B733: \(B733)\n" }
        if let DH8D = fleet.DH8D, DH8D > 0 { description += "DH8D: \(DH8D)\n" }
        if let DH8A = fleet.DH8A, DH8A > 0 { description += "DH8A: \(DH8A)\n" }
        if let B38M = fleet.B38M, B38M > 0 { description += "B38M: \(B38M)\n" }
        if let BK17 = fleet.BK17, BK17 > 0 { description += "BK17: \(BK17)\n" }
        if let D228 = fleet.D228, D228 > 0 { description += "D228: \(D228)\n" }
        if let A139 = fleet.A139, A139 > 0 { description += "A139: \(A139)\n" }
        if let EC35 = fleet.EC35, EC35 > 0 { description += "EC35: \(EC35)\n" }
        if let EC45 = fleet.EC45, EC45 > 0 { description += "EC45: \(EC45)\n" }
        if let FA7X = fleet.FA7X, FA7X > 0 { description += "FA7X: \(FA7X)\n" }
        if let C25A = fleet.C25A, C25A > 0 { description += "C25A: \(C25A)\n" }
        if let CL35 = fleet.CL35, CL35 > 0 { description += "CL35: \(CL35)\n" }
        if let E545 = fleet.E545, E545 > 0 { description += "E545: \(E545)\n" }
        if let E550 = fleet.E550, E550 > 0 { description += "E550: \(E550)\n" }
        description += "Total: \(fleet.total)"
        return description
            
    }
}
