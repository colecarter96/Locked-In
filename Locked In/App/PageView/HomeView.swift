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
    
    var body: some View {
        
        let dailyCompletions = getLast28DaysCompletionStatus(habits: habits)
        
        let lockedInStreak = getLockedInStreak(habits: habits)
        
        ScrollView{
            VStack (){
                    
                // Top Circles
                HStack (spacing: 90) {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.black)
                        .frame(width: 8, height: 8)
                    
                }
                .padding(.vertical, 16)
                
                LockCardView(statusText: "LockedIn", titleText: "\(lockedInStreak)", subtitleText: "Days Locked")
                    
                
                
                if habits.count > 0 {
                    WeeklyHabitView(
                        habitName: habits[0].name,
                        habitState: "UnLocked",
                        dayCompletionFlags: getCurrentWeekCompletionStatus(for: habits[0])
                    )
                }
                if habits.count > 1 {
                    WeeklyHabitView(
                        habitName: habits[1].name,
                        habitState: "UnLocked",
                        dayCompletionFlags: getCurrentWeekCompletionStatus(for: habits[1])
                    )
                }
                
//                WeeklyHabitView(habitName: habit1Name, habitState: habit1State)
//                
//                WeeklyHabitView(habitName: habit1Name, habitState: habit1State)
                
                MonthlyStreakView(dailyCompletionFlags: dailyCompletions)
                
            }
            .background(Color(red: 0.92, green: 0.92, blue:0.92, opacity: 1.0))
            .frame(maxWidth: .infinity, alignment: .top)
                
        }
        .background(Color(red: 0.92, green: 0.92, blue:0.92, opacity: 1.0))
        .frame(maxWidth: .infinity, alignment: .top)
        .scrollIndicators(.hidden) // hides scrollbars
        
        
        
        
    }
    

    
    func getLast28DaysCompletionStatus(habits: [Habit]) -> [Bool?] {
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
    
    func getLockedInStreak(habits: [Habit]) -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var streak = 0

        for offset in 0..<365 { // Arbitrary upper limit
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
