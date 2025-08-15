//
//  SmallLockWidget.swift
//  Locked In
//
//  Created by Cole Carter on 8/15/25.
//
//
//import WidgetKit
//import SwiftUI
//
//struct SmallLockEntry: TimelineEntry {
//    let date: Date
//    let unlockedHabits: Int
//}
//
//struct SmallLockProvider: TimelineProvider {
//    func placeholder(in context: Context) -> SmallLockEntry {
//        SmallLockEntry(date: Date(), unlockedHabits: 0)
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SmallLockEntry) -> Void) {
//        let entry = SmallLockEntry(date: Date(), unlockedHabits: 0)
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<SmallLockEntry>) -> Void) {
//        // Here you fetch data from shared storage (App Group UserDefaults)
//        let unlockedHabits = SharedData.shared.unlockedHabitsCount()
//        let entry = SmallLockEntry(date: Date(), unlockedHabits: unlockedHabits)
//
//        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*15)))
//        completion(timeline)
//    }
//}
//
//struct SmallLockWidgetView: View {
//    var entry: SmallLockEntry
//
//    var body: some View {
//        VStack {
//            Image(systemName: "lock.fill")
//                .resizable()
//                .scaledToFit()
//                .padding(10)
//            Text("\(entry.unlockedHabits) unlocked")
//                .font(.caption)
//        }
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct SmallLockWidget: Widget {
//    let kind: String = "SmallLockWidget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: SmallLockProvider()) { entry in
//            SmallLockWidgetView(entry: entry)
//        }
//        .configurationDisplayName("Small Lock")
//        .description("Shows how many habits are unlocked.")
//        .supportedFamilies([.systemSmall])
//    }
//}
