import Foundation

enum Constants {
    static let appName = "CultureCal"
    static let bundleId = "com.culturecal.app"
    
    enum UserDefaultsKeys {
        static let hasLaunched = "hasLaunched"
        static let isAuthenticated = "isAuthenticated"
    }
    
    enum Notification {
        static let connectivityStatusChanged = "connectivityStatusChanged"
    }
}