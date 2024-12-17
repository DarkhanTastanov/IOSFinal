import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var themeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        themeSwitch.isOn = UserDefaults.standard.bool(forKey: "isDarkTheme")

        themeSwitch.addTarget(self, action: #selector(themeSwitchToggled), for: .valueChanged)
    }

    private func setupUI() {
        view.backgroundColor = getCurrentThemeColor()
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
}

extension AppDelegate {
    func applyTheme(isDarkTheme: Bool) {
        let preference = isDarkTheme ? "dark" : "light"
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = preference == "dark" ? .dark : .light
        
    }
}

