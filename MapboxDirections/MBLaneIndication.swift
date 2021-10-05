import Foundation

public struct LaneIndication : OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let sharpRight = Self(rawValue: (1 << 1))
    public static let right = Self(rawValue: (1 << 2))
    public static let slightRight = Self(rawValue: (1 << 3))
    public static let straightAhead = Self(rawValue: (1 << 4))
    public static let slightLeft = Self(rawValue: (1 << 5))
    public static let left = Self(rawValue: (1 << 6))
    public static let sharpLeft = Self(rawValue: (1 << 7))
    public static let uTurn = Self(rawValue: (1 << 8))
}

extension LaneIndication: CustomStringConvertible {
    /**
     Creates a lane indication from the given description strings.
     */
    public init?(descriptions: [String]) {
        var laneIndication: LaneIndication = []
        for description in descriptions {
            switch description {
            case "sharp right":
                laneIndication.insert(.sharpRight)
            case "right":
                laneIndication.insert(.right)
            case "slight right":
                laneIndication.insert(.slightRight)
            case "straight":
                laneIndication.insert(.straightAhead)
            case "slight left":
                laneIndication.insert(.slightLeft)
            case "left":
                laneIndication.insert(.left)
            case "sharp left":
                laneIndication.insert(.sharpLeft)
            case "uturn":
                laneIndication.insert(.uTurn)
            case "none":
                break
            default:
                return nil
            }
        }
        self.init(rawValue: laneIndication.rawValue)
    }
    
    public var description: String {
        if isEmpty {
            return "none"
        }
        
        var descriptions: [String] = []
        if contains(.sharpRight) {
            descriptions.append("sharp right")
        }
        if contains(.right) {
            descriptions.append("right")
        }
        if contains(.slightRight) {
            descriptions.append("slight right")
        }
        if contains(.straightAhead) {
            descriptions.append("straight")
        }
        if contains(.slightLeft) {
            descriptions.append("slight left")
        }
        if contains(.left) {
            descriptions.append("left")
        }
        if contains(.sharpLeft) {
            descriptions.append("sharp left")
        }
        if contains(.uTurn) {
            descriptions.append("uturn")
        }
        return descriptions.joined(separator: ",")
    }
}
