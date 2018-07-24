import Foundation
import Mapbox


extension MGLAccountManager{
    
    static let mapboxChinaBaseAPIURL = "https://api.mapbox.cn"
    static let mapboxChinaBaseURLHost = "api.mapbox.cn"
    static let mapboxChinaDayStyleURL = "mapbox://styles/mapbox/streets-zh-v1"
    static let mapboxChinaNightStyleURL = "mapbox://styles/mapbox/dark-zh-v1"
    
    // Value of whether the map is China map or not
    public class var hasChinaBaseURL : Bool{
        let apiBaseURL = Bundle.main.object(forInfoDictionaryKey:"MGLMapboxAPIBaseURL") as? String
        return apiBaseURL == mapboxChinaBaseAPIURL
    }
    
}
