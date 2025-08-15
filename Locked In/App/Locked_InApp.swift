//
//  Locked_InApp.swift
//  Locked In
//
//  Created by Cole Carter on 8/3/25.
//

import SwiftUI
import UserNotifications

class ThemeManager: ObservableObject {
    @AppStorage("isLightMode") var isLightMode: Bool = false {
        willSet { objectWillChange.send() } // so the UI updates when toggled
    }
    
    var cardColor : Color { isLightMode ?  Color(red: 0.90, green: 0.90, blue: 0.90, opacity: 1.0) :  Color(red: 0.10, green: 0.10, blue: 0.10, opacity: 1.0) }
    var textColor : Color { isLightMode ? .black : .white}
    var habitStatus : Color { .gray }
    var backgroundColor : Color { isLightMode ? Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0) : Color(red: 0.01, green: 0.01, blue: 0.01, opacity: 1.0)}
    var lockButton : Color { isLightMode ? Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0) : Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0) }
    var controlRect : Color { isLightMode ? Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0) : Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0)}
    var circlesSelected : Color { isLightMode ?  Color.black : Color.white }
    var circlesNotSel : Color { isLightMode ? Color.gray : Color.gray }
}

@main
struct Locked_InApp: App {
    
    @StateObject private var habitStore = HabitStore()
    @StateObject var themeManager = ThemeManager()
    
    init() {
            requestNotificationPermission()
            scheduleDailyReminder()
        }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
//                .background(Color(red: 0.97, green: 0.97, blue: 0.97, opacity: 1.0))
                .environmentObject(themeManager)
                .environmentObject(habitStore)
            
        }
    }
    
    func requestNotificationPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                if let error = error {
                    print("Error requesting notification permission: \(error)")
                }
                print("Permission granted: \(granted)")
            }
        }
        
        func scheduleDailyReminder() {
            let center = UNUserNotificationCenter.current()
            
            // Remove old notifications so we don't duplicate
            center.removeAllPendingNotificationRequests()
            
            var dateComponents = DateComponents()
            dateComponents.hour = 13 // 1 PM in 24h format
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let content = UNMutableNotificationContent()
            content.title = "Stay Locked In"
            content.sound = .default
            
            let request = UNNotificationRequest(identifier: "dailyLockedInReminder", content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
}
