import UIKit
import Kingfisher

class AirlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, AirlineManagerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var barText = ""
    var airlines: [Airline] = []
    var filteredAirlines: [Airline] = []
    var airlineManager = AirlineManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        tableView.separatorStyle = .none
        airlineManager.delegate = self
        if let savedSearchText = UserDefaults.standard.string(forKey: "savedSearchText") {
            searchBar.text = savedSearchText
            fetchAirlines(searchText: savedSearchText)
        } else {
            fetchAirlines(searchText: "")
        }
        loadSavedAirlines()
    }
    
    
    func onHeroDidFetch(_ airlines: [Airline]) {
        self.airlines = airlines
        self.filteredAirlines = airlines
        tableView.reloadData()
        saveAirlines()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAirlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirlineCell", for: indexPath) as! AirlineCell
        let airline = filteredAirlines[indexPath.row]
        cell.configure(with: airline)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAirline = filteredAirlines[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "AirlineDetailViewController") as! AirlineDetailViewController
        detailVC.airline = selectedAirline
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        
    func fetchAirlines(searchText: String) {
        airlineManager.fetchAirlines(searchText: searchText) { [weak self] fetchedAirlines in
            guard let self = self else { return }
            if let airlines = fetchedAirlines {
                self.airlines = airlines
                self.filteredAirlines = airlines
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        UserDefaults.standard.set(searchText, forKey: "savedSearchText")
        
        fetchAirlines(searchText: searchText)
    }
    func saveAirlines() {
        guard let encodedAirlines = try? JSONEncoder().encode(self.airlines) else { return }
        UserDefaults.standard.set(encodedAirlines, forKey: "savedAirlines")
    }

    func loadSavedAirlines() {
        guard let savedAirlinesData = UserDefaults.standard.data(forKey: "savedAirlines") else { return }
        if let savedAirlines = try? JSONDecoder().decode([Airline].self, from: savedAirlinesData) {
            self.airlines = savedAirlines
            self.filteredAirlines = savedAirlines
            tableView.reloadData()
        }
    }
}

