/**
 To find more pieces of the UI to customize, checkout DayStyle.swift.
 */
// MARK: MaptilerDayStyle
class MaptilerDayStyle: DayStyle {
    
    required init() {
        super.init()
        mapStyleURL = URL(string: Bundle.main.object(forInfoDictionaryKey: "MGLMapboxStyleUrl") as? String ?? "mapbox://mapbox.mapbox-streets-v7")!
        styleType = .day
    }
    
    override func apply() {
        super.apply()
    }
}

// MARK: MaptilerNightStyle
class MaptilerNightStyle: NightStyle {
    
    required init() {
        super.init()
        mapStyleURL = URL(string: Bundle.main.object(forInfoDictionaryKey: "MGLMapboxStyleUrl") as? String ?? "mapbox://mapbox.mapbox-streets-v7")!
        styleType = .night
    }
    
    override func apply() {
        super.apply()
    }
}
