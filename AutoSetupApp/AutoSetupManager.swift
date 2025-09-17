import UIKit
import UserNotifications

class AutoSetupManager {
    static let shared = AutoSetupManager()
    
    private let userDefaults = UserDefaults.standard
    private let setupCompleteKey = "AutoSetupComplete"
    private let appLaunchCountKey = "AppLaunchCount"
    private let regionSetKey = "RegionSet"
    
    private init() {}
    
    // MARK: - Setup Status Management
    
    func isSetupComplete() -> Bool {
        return userDefaults.bool(forKey: setupCompleteKey)
    }
    
    func markSetupComplete() {
        userDefaults.set(true, forKey: setupCompleteKey)
        userDefaults.synchronize()
    }
    
    func resetSetup() {
        userDefaults.removeObject(forKey: setupCompleteKey)
        userDefaults.removeObject(forKey: regionSetKey)
        userDefaults.synchronize()
    }
    
    // MARK: - App Launch Tracking
    
    func incrementLaunchCount() {
        let currentCount = userDefaults.integer(forKey: appLaunchCountKey)
        userDefaults.set(currentCount + 1, forKey: appLaunchCountKey)
        userDefaults.synchronize()
    }
    
    func getLaunchCount() -> Int {
        return userDefaults.integer(forKey: appLaunchCountKey)
    }
    
    // MARK: - Region Management
    
    func setRegion(_ region: String) {
        userDefaults.set(region, forKey: regionSetKey)
        userDefaults.synchronize()
    }
    
    func getSelectedRegion() -> String? {
        return userDefaults.string(forKey: regionSetKey)
    }
    
    // MARK: - Auto Setup Flow
    
    func checkAndTriggerAutoSetup() {
        let launchCount = getLaunchCount()
        
        // First launch - show initial setup
        if launchCount == 1 {
            showInitialSetupNotification()
        }
        // After region is set, trigger app restart simulation
        else if launchCount == 2 && getSelectedRegion() != nil {
            showRestartNotification()
        }
        // After restart, continue with date/time and privacy settings
        else if launchCount >= 3 {
            showContinueSetupNotification()
        }
    }
    
    private func showInitialSetupNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Auto Setup Required"
        content.body = "Please complete the initial setup: Settings → General → Language & Region → Region → Japan"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: "initial-setup",
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    private func showRestartNotification() {
        let content = UNMutableNotificationContent()
        content.title = "App Restart Required"
        content.body = "Region has been set to Japan. The app will restart to apply changes."
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: "app-restart",
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    private func showContinueSetupNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Continue Setup"
        content.body = "Now configure: General → Date & Time → Privacy → Location Services"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: "continue-setup",
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    // MARK: - Notification Permission
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
    
    // MARK: - Setup Progress
    
    func getSetupProgress() -> Float {
        let launchCount = getLaunchCount()
        let hasRegion = getSelectedRegion() != nil
        
        if launchCount == 0 {
            return 0.0
        } else if launchCount == 1 {
            return 0.2
        } else if launchCount == 2 && hasRegion {
            return 0.4
        } else if launchCount >= 3 {
            return 0.6
        } else if isSetupComplete() {
            return 1.0
        }
        
        return 0.0
    }
    
    func getCurrentStep() -> String {
        let launchCount = getLaunchCount()
        let hasRegion = getSelectedRegion() != nil
        
        if launchCount == 0 {
            return "Ready to start"
        } else if launchCount == 1 {
            return "Set Region to Japan"
        } else if launchCount == 2 && hasRegion {
            return "App Restart"
        } else if launchCount >= 3 {
            return "Configure Date/Time & Privacy"
        } else if isSetupComplete() {
            return "Setup Complete"
        }
        
        return "Unknown"
    }
}
