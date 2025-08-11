//
//  Locked_InApp.swift
//  Locked In
//
//  Created by Cole Carter on 8/3/25.
//

import SwiftUI
import UserNotifications

@main
struct Locked_InApp: App {
    
    @StateObject private var habitStore = HabitStore()
    
    init() {
            requestNotificationPermission()
            scheduleDailyReminder()
        }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .background(Color(red: 0.97, green: 0.97, blue: 0.97, opacity: 1.0))
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
