//
//  HomeView.swift
//  Locked In
//
//  Created by Cole Carter on 8/5/25.
//

import SwiftUI

struct HomeView: View{
    
    var habit1Name: String
    var habit1State: String
    
    let habits: [Habit]
    
    @Binding var selectedTab: Int
    
    @EnvironmentObject var themeManager : ThemeManager
    
    var body: some View {
        
        let dailyCompletions = getLast28DaysCompletionStatus(habits: habits)
        
        let lockedInStreak = getLockedInStreak(habits: habits)
        
        ScrollView{
            VStack (){
                    
                // Top Circles
//                HStack (spacing: 90) {
//                    Circle()
//                        .fill(Color.gray)
//                        .frame(width: 8, height: 8)
//                    Circle()
//                        .fill(Color.black)
//                        .frame(width: 8, height: 8)
//                    
//                }
//                .padding(.vertical, 16)
                
                CirclesNavView(currTab: $selectedTab, totalPages: habits.count + 2)
                
                LockCardView(statusText: "LockedIn", titleText: "\(lockedInStreak)", subtitleText: "Days Locked")
                
                
                    
                
                ForEach(habits.indices, id: \.self) { index in
//                    Button {
//                        selectedTab = index + 1  // +1 because 0 = HomeView
//                    } label: {
//                        WeeklyHabitView(
//                            habitName: habits[index].name,
//                            habitState: "UnLocked",
//                            dayCompletionFlags: getCurrentWeekCompletionStatus(for: habits[index])
//                        )
//                    }
//                    .buttonStyle(.plain)
                    
                    
                    WeeklyHabitView(
                        habitName: habits[index].name,
                        habitState: "UnLocked",
                        dayCompletionFlags: getCurrentWeekCompletionStatus(for: habits[index])
                    )
                    .onTapGesture {
                        selectedTab = index + 2
                    }
                    
                }
                
                if habits.isEmpty {
                    Button {
                        selectedTab = 0 // last page is AddView in your pager
                    } label: {
                        WeeklyHabitView(
                            habitName: "Click here to create a new habit",
                            habitState: "LockedIn",
                            dayCompletionFlags: Array(repeating: false, count: 7) // empty week
                        )
                    }
                    .buttonStyle(.plain)
                    .transition(.opacity) // or .slide
                    .animation(.easeInOut, value: habits)
                }
                    
                
                
                if !habits.isEmpty {
                    MonthlyStreakView(dailyCompletionFlags: dailyCompletions)
                        .transition(.opacity) // or .slide
                        .animation(.easeInOut, value: habits)
                }
                
                
            }
            .background(themeManager.backgroundColor)
            .frame(maxWidth: .infinity, alignment: .top)
                
        }
        .background(themeManager.backgroundColor)
        .frame(maxWidth: .infinity, alignment: .top)
        .scrollIndicators(.hidden) // hides scrollbars
        
        
        
        
    }
    

    
    func getLast28DaysCompletionStatus(habits: [Habit]) -> [Bool?] {
        
        guard !habits.isEmpty else { return [] }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // Get this week's Saturday
        let weekday = calendar.component(.weekday, from: today) // Sunday = 1 ... Saturday = 7
        let daysUntilSaturday = 7 - weekday
        let endDate = calendar.date(byAdding: .day, value: daysUntilSaturday, to: today)!

        // Start 27 days before the upcoming Saturday
        let startDate = calendar.date(byAdding: .day, value: -27, to: endDate)!

        var result: [Bool?] = []

        for offset in 0..<28 {
            let date = calendar.date(byAdding: .day, value: offset, to: startDate)!

            if date > today {
                result.append(nil) // Future day
                continue
            }

            let allComplete = habits.allSatisfy { habit in
                habit.history.contains { key, value in
                    value && calendar.isDate(key, inSameDayAs: date)
                }
            }
            result.append(allComplete)
        }

        return result
    }
    
//    func getLockedInStreak(habits: [Habit]) -> Int {
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: Date())
//        var streak = 0
//        
//        if habits.count == 0 {
//            return 0
//        }
//
//        for offset in 0..<365 { // Arbitrary upper limit
//            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { break }
//
//            let allComplete = habits.allSatisfy { habit in
//                habit.history.contains { key, value in
//                    value && calendar.isDate(key, inSameDayAs: date)
//                }
//            }
//
//            if allComplete {
//                streak += 1
//            } else {
//                break
//            }
//        }
//
//        return streak
//    }
    func getLockedInStreak(habits: [Habit]) -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        guard habits.count > 0 else { return 0 }
        
        var streak = 0
        
        // Step 1: Check consecutive days starting **yesterday**
        for offset in 1..<365 { // start at 1 to skip today
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { break }
            
            let allComplete = habits.allSatisfy { habit in
                habit.history.contains { key, value in
                    value && calendar.isDate(key, inSameDayAs: date)
                }
            }
            
            if allComplete {
                streak += 1
            } else {
                break
            }
        }
        
        // Step 2: Add today if all habits are completed
        let todayComplete = habits.allSatisfy { habit in
            habit.history[today] == true
        }
        
        if todayComplete {
            streak += 1
        }
        
        return streak
    }



    // Gets the start of the week (Sunday) for a given date, offset by a number of weeks
    func getStartOfWeek(for date: Date, offsetBy weeks: Int) -> Date? {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday

        guard let thisWeekStart = calendar.dateInterval(of: .weekOfYear, for: date)?.start else {
            return nil
        }

        return calendar.date(byAdding: .weekOfYear, value: weeks, to: thisWeekStart)
    }
    
    func getCurrentWeekCompletionStatus(for habit: Habit) -> [Bool] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())?.start else {
            return Array(repeating: false, count: 7)
        }

        let today = calendar.startOfDay(for: Date())
        return (0..<7).map { offset in
            let day = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
            if day > today {
                return false // Don’t mark future days as complete
            }
            return habit.history.contains { key, value in
                value && calendar.isDate(key, inSameDayAs: day)
            }
        }
    }

}



//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(habit1Name: "Read 30 Mins", habit1State: "UnLocked")
//    }
//}
