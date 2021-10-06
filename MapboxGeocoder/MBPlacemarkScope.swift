import Mapbox

public struct MBPlacemarkScope : OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let country = Self(rawValue: (1 << 1))
    public static let region = Self(rawValue: (1 << 2))
    public static let district = Self(rawValue: (1 << 3))
    public static let postalCode = Self(rawValue: (1 << 4))
    public static let place = Self(rawValue: (1 << 5))
    public static let locality = Self(rawValue: (1 << 6))
    public static let neighborhood = Self(rawValue: (1 << 7))
    public static let address = Self(rawValue: (1 << 8))
    public static let landmark = Self(rawValue: (1 << 10))
    public static let pointOfInterest = Self(rawValue: Self.landmark.rawValue | (1 << 9))
    public static let all = Self(rawValue: 0x0ffff)
}

public typealias PlacemarkScope = MBPlacemarkScope

extension PlacemarkScope: CustomStringConvertible {
    /**
     Initializes a placemark scope bitmask corresponding to the given array of string representations of scopes.
     */
    public init?(descriptions: [String]) {
        var scope: PlacemarkScope = []
        for description in descriptions {
            switch description {
            case "country":
                scope.update(with: .country)
            case "region":
                scope.update(with: .region)
            case "district":
                scope.update(with: .district)
            case "postcode":
                scope.update(with: .postalCode)
            case "place":
                scope.update(with: .place)
            case "locality":
                scope.update(with: .locality)
            case "neighborhood":
                scope.update(with: .neighborhood)
            case "address":
                scope.update(with: .address)
            case "poi.landmark":
                scope.update(with: .landmark)
            case "poi":
                scope.update(with: .pointOfInterest)
            default:
                return nil
            }
        }
        self.init(rawValue: scope.rawValue)
    }
    
    public var description: String {
        var descriptions: [String] = []
        if contains(.country) {
            descriptions.append("country")
        }
        if contains(.region) {
            descriptions.append("region")
        }
        if contains(.district) {
            descriptions.append("district")
        }
        if contains(.postalCode) {
            descriptions.append("postcode")
        }
        if contains(.place) {
            descriptions.append("place")
        }
        if contains(.locality) {
            descriptions.append("locality")
        }
        if contains(.neighborhood) {
            descriptions.append("neighborhood")
        }
        if contains(.address) {
            descriptions.append("address")
        }
        if contains(.landmark) {
            descriptions.append(contains(.pointOfInterest) ? "poi" : "poi.landmark")
        }
        return descriptions.joined(separator: ",")
    }
}
