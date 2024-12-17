import UIKit
import Kingfisher

class AirlineCell: UITableViewCell {
    @IBOutlet weak var airlineImageView: UIImageView!
    @IBOutlet weak var airlineName: UILabel!

    func configure(with airline: Airline) {
        airlineName.text = airline.name
        if let url = URL(string: airline.logoURL ?? "") {
            airlineImageView.kf.setImage(with: url)
        } else {
            return
        }
    }
}
