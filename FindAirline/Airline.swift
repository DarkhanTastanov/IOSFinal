import Foundation

struct Airline: Codable {
    let iata: String
    let icao: String
    let fleet: Fleet
    let logoURL: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case iata, icao, fleet
        case logoURL = "logo_url"
    }
}

struct Fleet: Codable {
    let A20N: Int?
    let A21N: Int?
    let A320: Int?
    let A321: Int?
    let B752: Int?
    let B763: Int?
    let E290: Int?
    let B738: Int?
    let B744: Int?
    let B772: Int?
    let B773: Int?
    let B77W: Int?
    let B78X: Int?
    let IL76: Int?
    let LJ75: Int?
    let B350: Int?
    let CL30: Int?
    let J328: Int?
    let LJ45: Int?
    let PC12: Int?
    let GLF5: Int?
    let LJ60: Int?
    let AN12: Int?
    let B733: Int?
    let DH8D: Int?
    let DH8A: Int?
    let B38M: Int?
    let BK17: Int?
    let D228: Int?
    let A139: Int?
    let EC35: Int?
    let EC45: Int?
    let FA7X: Int?
    let C25A: Int?
    let CL35: Int?
    let E545: Int?
    let E550: Int?
    let total: Int
}
