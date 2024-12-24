import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()

    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favoriteAirlines"

    private var favoriteAirlines: [Airline] = []
    
    init() {
        favoriteAirlines = getFavorites()
    }
    func addFavorite(_ airline: Airline) {
        if !favoriteAirlines.contains(where: { $0.name == airline.name }) {
            favoriteAirlines.append(airline)
            saveFavorites()
            print("Added \(airline.name) to favorites. Total favorites: \(favoriteAirlines.count)")
        } else {
            print("\(airline.name) is already a favorite.")
        }
    }

    func removeFavorite(_ airline: Airline) {
        favoriteAirlines.removeAll { $0.name == airline.name }
        saveFavorites()
        print("Removed \(airline.name) from favorites. Total favorites: \(favoriteAirlines.count)")
    }

    func isFavorite(_ airline: Airline) -> Bool {
        let isFav = favoriteAirlines.contains(where: { $0.name == airline.name })
        print("\(airline.name) is favorite: \(isFav)")
        return isFav
    }

    func getFavorites() -> [Airline] {
        guard let data = userDefaults.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([Airline].self, from: data) else {
            print("No favorites found in UserDefaults.")
            return []
        }
        print("Returning \(favorites.count) favorite airlines from UserDefaults.")
        return favorites
    }

    func updateFavorite(_ airline: Airline) {
        if airline.isFavorite {
            addFavorite(airline)
        } else {
            removeFavorite(airline)
        }
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteAirlines) {
            userDefaults.set(encoded, forKey: favoritesKey)
            print("Saved \(favoriteAirlines.count) favorite airlines to UserDefaults.")
        } else {
            print("Failed to encode favorite airlines.")
        }
    }
}
