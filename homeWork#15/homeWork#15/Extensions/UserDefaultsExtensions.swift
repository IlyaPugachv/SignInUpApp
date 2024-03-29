import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case email
        case name
        case password
    }
    
    func reset() {
        let allCases = Keys.allCases
        allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
