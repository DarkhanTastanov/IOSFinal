import UIKit
import Kingfisher

class FavoriteAirlineCell: UITableViewCell {
    @IBOutlet weak var airlineImageView: UIImageView!
    @IBOutlet weak var airlineNameLabel: UILabel!

    func configure(with airline: Airline) {
        airlineNameLabel.text = airline.name
        if let url = URL(string: airline.logoURL ?? "") {
            airlineImageView.kf.setImage(with: url)
        } else {
            airlineImageView.image = UIImage(named: "horizont")
        }
    }
}
