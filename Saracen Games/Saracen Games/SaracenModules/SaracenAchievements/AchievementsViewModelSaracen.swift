import SwiftUI

class AchievementsViewModelSaracen: ObservableObject {
    
    @Published var achievements: [AchievementSaracen] = [
        AchievementSaracen(num: 1, name: "COMPLETE THE FIRST LEVEL", isAchieved: false),
        AchievementSaracen(num: 2, name: "Complete 5 levels in a row without any crashes", isAchieved: false),
        AchievementSaracen(num: 3, name: "Complete a bridge level without losing coins", isAchieved: false),
        AchievementSaracen(num: 4, name: "Complete all levels in a row without any crashes", isAchieved: false),
        AchievementSaracen(num: 5, name: "Collect 1000 coins", isAchieved: false)

    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeySG"
    
    func achieveToggle(_ achive: AchievementSaracen) {
        guard let index = achievements.firstIndex(where: { $0.id == achive.id })
        else {
            return
        }
        achievements[index].isAchieved.toggle()
        
    }
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([AchievementSaracen].self, from: savedData) {
            achievements = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct AchievementSaracen: Codable, Hashable, Identifiable {
    var id = UUID()
    var num: Int
    var name: String
    var isAchieved: Bool
}
