//
//  MainView.swift
//  Locked In
//
//  Created by Cole Carter on 8/5/25.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 0 // index of the current tab
        
    private let totalTabs = 4 // adjust if you add more views
    
    @State private var habits: [Habit] = [
        Habit(id: UUID(),
              name: "Read 30 Mins",
              streakGoal: 7,
              frequency: .daily,
              history: MainView.generateTempHistory(for: 21)),
        Habit(id: UUID(),
              name: "Meditate",
              streakGoal: 14,
              frequency: .everyOtherDay,
              history: MainView.generateTempHistory(for: 21))
    ]
    
    var body: some View {
        //        TabView {
        //            HomeView(habit1Name: "Read 30 Mins", habit1State: "UnLocked")
        //            HabitView(statusText: "UnLocked", habitTitle: "Read 30 Mins",
        //                      habitType: "Daily", currStreak: "0", daysLocked: "9", lockGoal: "67")
        //            HabitView(statusText: "UnLocked", habitTitle: "Read 30 Mins",
        //                      habitType: "Daily", currStreak: "0", daysLocked: "9", lockGoal: "67")
        //            AddView()
        //
        //        }
        //        .ignoresSafeArea()
        //        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

        
        CustomPagerView(totalPages: 2 + habits.count) {
            HomeView(habit1Name: "Read 30 Mins", habit1State: "UnLocked", habits: habits)
            
            ForEach($habits) { $hab in   // 👈 $hab is a Binding<Habit>
                HabitView(
                    statusText: "UnLocked",
                    habit: $hab,          // 👈 Pass the binding
                    onUpdate: { updatedHabit in
                        if let index = habits.firstIndex(where: { $0.id == updatedHabit.id }) {
                            habits[index] = updatedHabit
                        }
                    },
                    onDelete: { deletedHabit in
                        habits.removeAll { $0.id == deletedHabit.id }
                    }
                )
            }
//            ForEach(habits) { hab in
//                HabitView(
//                    statusText: "UnLocked",
//                    habit: hab,
//                    onUpdate: { updatedHabit in
//                        if let index = habits.firstIndex(where: { $0.id == updatedHabit.id }) {
//                            habits[index] = updatedHabit
//                        }
//                    },
//                    onDelete: { deletedHabit in
//                        habits.removeAll { $0.id == deletedHabit.id }
//                    }
//                )
//            }
            AddView { newHabit in
                print("MainView received new habit: \(newHabit.name)")
                habits.append(newHabit)
            }
        }
    }
    
    static func generateTempHistory(for days: Int) -> [Date: Bool] {
        var history: [Date: Bool] = [:]
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        for offset in 0..<days {
            if let date = calendar.date(byAdding: .day, value: -offset, to: today) {
                // Deterministic pattern: complete every 2nd day (even offsets)
                let completed = (offset % 2 == 0)
                history[date] = completed
            }
        }
        return history
    }
//    static func generateTempHistory() -> [Date: Bool] {
//        var history: [Date: Bool] = [:]
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: Date())
//
//        // Find the Saturday of the current week (ending date of the 28-day grid)
//        let weekday = calendar.component(.weekday, from: today) // Sunday = 1 ... Saturday = 7
//        let daysUntilSaturday = 7 - weekday
//        guard let endDate = calendar.date(byAdding: .day, value: daysUntilSaturday, to: today) else { return [:] }
//
//        // Start 27 days before endDate (to make 28 days total)
//        guard let startDate = calendar.date(byAdding: .day, value: -27, to: endDate) else { return [:] }
//
//        for offset in 0..<28 {
//            if let date = calendar.date(byAdding: .day, value: offset, to: startDate) {
//                // Only fill in up to today, rest are treated as future or unavailable
//                if date <= today {
//                    let daysAgo = calendar.dateComponents([.day], from: date, to: today).day ?? 0
//                    // Deterministic pattern: mark every other day completed
//                    let completed = (daysAgo % 2 == 0)
//                    history[date] = completed
//                }
//            }
//        }

//        return history
//    }


   
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
