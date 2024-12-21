import UIKit
import Kingfisher

class AirlineCell: UITableViewCell {
    @IBOutlet weak var airlineImageView: UIImageView!
    @IBOutlet weak var airlineName: UILabel!
    @IBOutlet weak var airlineThemeImageView: UIImageView!

    func configure(with airline: Airline) {
        airlineName.text = airline.name
        if let url = URL(string: airline.logoURL ?? "") {
            airlineImageView.kf.setImage(with: url)
        } else {
            return
        }
    }
    override func awakeFromNib() {
            super.awakeFromNib()
            NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange(_:)), name: .themeDidChange, object: nil)
        }

        deinit {
            NotificationCenter.default.removeObserver(self, name: .themeDidChange, object: nil)
        }

        @objc private func themeDidChange(_ notification: Notification) {
            guard let isDarkTheme = notification.userInfo?["isDarkTheme"] as? Bool else { return }
            applyThemeToImage(isDarkTheme: isDarkTheme)
        }

        private func applyThemeToImage(isDarkTheme: Bool) {
            if let image = airlineThemeImageView.image {
                if isDarkTheme {
                    airlineThemeImageView.image = image.withRenderingMode(.alwaysTemplate)
                    airlineThemeImageView.tintColor = .black
                } else {
                    airlineThemeImageView.image = UIImage(named: "vertical")
                }
            }
        }

}
