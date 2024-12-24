import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var favoritesTableView: UITableView!
    var favoriteAirlines: [Airline] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        themeSwitch.isOn = UserDefaults.standard.bool(forKey: "isDarkTheme")
        themeSwitch.addTarget(self, action: #selector(themeSwitchToggled), for: .valueChanged)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        loadFavoriteAirlines()
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteAirlineToggled(_:)), name: .favoriteAirlineToggled, object: nil)
        loadFavoriteAirlines()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteAirlines()
        favoritesTableView.reloadData()
    }
    private func setupUI() {
        view.backgroundColor = getCurrentThemeColor()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoriteAirlineToggled, object: nil)
    }

    @objc private func favoriteAirlineToggled(_ notification: Notification) {
        loadFavoriteAirlines()
        favoritesTableView.reloadData()
    }

    private func loadFavoriteAirlines() {
        favoriteAirlines = FavoritesManager.shared.getFavorites()
    }

    
    @objc private func themeSwitchToggled() {
        let isDarkTheme = themeSwitch.isOn
        UserDefaults.standard.set(isDarkTheme, forKey: "isDarkTheme")

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.applyTheme(isDarkTheme: isDarkTheme)
            setupUI()
        }
    }

    private func getCurrentThemeColor() -> UIColor {
        return UserDefaults.standard.bool(forKey: "isDarkTheme") ? .black : .white
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteAirlines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteAirlineCell", for: indexPath) as! FavoriteAirlineCell
        let airline = favoriteAirlines[indexPath.row]
        cell.configure(with: airline)
        return cell
    }

}
extension AppDelegate {
    func applyTheme(isDarkTheme: Bool) {
        let preference = isDarkTheme ? "dark" : "light"
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = preference == "dark" ? .dark : .light
        NotificationCenter.default.post(name: .themeDidChange, object: nil, userInfo: ["isDarkTheme": isDarkTheme])
    }
}

extension Notification.Name {
    static let themeDidChange = Notification.Name("themeDidChange")
    static let favoriteAirlineToggled = Notification.Name("favoriteAirlineToggled")

}
