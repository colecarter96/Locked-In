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
    
    @EnvironmentObject var habitStore: HabitStore
    
    var body: some View {
        
        
        
       
            
        
        CustomPagerView(currentIndex: $selectedTab, totalPages: 2 + habitStore.habits.count) {
            
            HomeView(habit1Name: "Read 30 Mins",
                     habit1State: "UnLocked",
                     habits: habitStore.habits,
                     selectedTab: $selectedTab)
            
            ForEach($habitStore.habits) { $hab in   // 👈 $hab is a Binding<Habit>
                HabitView(selectedTab: $selectedTab, habitCount: habitStore.habits.count + 2,
                    statusText: "UnLocked",
                    habit: $hab,          // 👈 Pass the binding
                    onUpdate: { updatedHabit in
                        if let index = habitStore.habits.firstIndex(where: { $0.id == updatedHabit.id }) {
                            habitStore.habits[index] = updatedHabit
                            habitStore.saveHabits()
                        }
                    },
                    onDelete: { deletedHabit in
                        habitStore.habits.removeAll { $0.id == deletedHabit.id }
                        habitStore.saveHabits()
                    }
                )
            }
            
            AddView(
                onAddHabit: { newHabit in
                    print("MainView received new habit: \(newHabit.name)")
                    habitStore.addHabit(newHabit)
                },
                selectedTab: $selectedTab,
                habitCount: habitStore.habits.count + 2
            )
        }
        
    }
//        ZStack{
//            HabitStoreTestView()
//        }
    
    
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

   
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(HabitStore()) // Required for preview
    }
}
