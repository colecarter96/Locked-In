//
//  HabitModel.swift
//  Locked In
//
//  Created by Cole Carter on 8/5/25.
//

    import Foundation

    enum Weekday: Int, Codable, CaseIterable {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

        var displayName: String {
            switch self {
            case .sunday: return "Sunday"
            case .monday: return "Monday"
            case .tuesday: return "Tuesday"
            case .wednesday: return "Wednesday"
            case .thursday: return "Thursday"
            case .friday: return "Friday"
            case .saturday: return "Saturday"
            }
        }
    }

    extension Date {
        func strippedTime() -> Date {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
            return Calendar.current.date(from: components)!
        }
    }


    struct Habit: Identifiable, Equatable, Codable {
        let id: UUID
        var name: String
        var streakGoal: Int
        var frequency: Frequency
        var history: [Date: Bool]
        
        var isCompletedToday: Bool {
            let today = Date().strippedTime()
            return history[today] ?? false
        }
        
        var streak: Int {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
            var streak = 0

            // Step 1: Count consecutive days starting from yesterday
            for offset in 0..<365 {
                guard let date = calendar.date(byAdding: .day, value: -offset, to: yesterday) else { break }

                let completed = history.contains { key, value in
                    value && calendar.isDate(key, inSameDayAs: date)
                }

                if completed {
                    streak += 1
                } else {
                    break
                }
            }

            // Step 2: If today is completed, add it to the streak
            let todayCompleted = history.contains { key, value in
                value && calendar.isDate(key, inSameDayAs: today)
            }

            if todayCompleted {
                streak += 1
            }

            return streak
        }
        
        
        
        enum Frequency: Codable, Equatable {
            case daily
            case everyOtherDay
            case custom([Weekday])
            
            private enum CodingKeys: String, CodingKey {
                case type
                case days
            }
            
            private enum FrequencyType: String, Codable {
                case daily
                case everyOtherDay
                case custom
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(FrequencyType.self, forKey: .type)
                
                switch type {
                case .daily:
                    self = .daily
                case .everyOtherDay:
                    self = .everyOtherDay
                case .custom:
                    let days = try container.decode([Weekday].self, forKey: .days)
                    self = .custom(days)
                }
            }
            
            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                switch self {
                case .daily:
                    try container.encode(FrequencyType.daily, forKey: .type)
                case .everyOtherDay:
                    try container.encode(FrequencyType.everyOtherDay, forKey: .type)
                case .custom(let days):
                    try container.encode(FrequencyType.custom, forKey: .type)
                    try container.encode(days, forKey: .days)
                }
            }
        }
        
        
        
        
        
        
        
    }

    extension Habit.Frequency {
        var displayName: String {
            switch self {
            case .daily:
                return "Daily"
            case .everyOtherDay:
                return "Every Other Day"
            case .custom(let days):
                let dayNames = days.map { $0.displayName } // Assuming Weekday has a displayName property
                return "Custom (\(dayNames.joined(separator: ", ")))"
            }
        }
    }


    extension Habit {
        /// Returns the current streak (most recent consecutive days with `true`)
        var currentStreak: Int {
            let sortedDates = history.keys.sorted(by: >) // newest to oldest
            var streak = 0
            
            let calendar = Calendar.current
            var expectedDate = Date() // today

            for date in sortedDates {
                // Strip times and compare only days
                if calendar.isDate(date, inSameDayAs: expectedDate) {
                    if history[date] == true {
                        streak += 1
                        expectedDate = calendar.date(byAdding: .day, value: -1, to: expectedDate)!
                    } else {
                        break
                    }
                }
            }
            return streak
        }

        /// Returns past 28 days as 1/0 array (used in MonthlyStreakView)
        var last28DaysStatus: [Int] {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            return (0..<28).map { offset in
                let date = calendar.date(byAdding: .day, value: -offset, to: today)!
                return history[date] == true ? 1 : 0
            }.reversed() // earliest to latest
        }
        
        func isComplete(from start: Date, to end: Date) -> Bool {
            let calendar = Calendar.current
            for date in dateRange(from: start, to: end) {
                // Check if history has true for this date (ignoring time)
                let completed = history.contains { (key, value) in
                    value && calendar.isDate(key, inSameDayAs: date)
                }
                if !completed {
                    return false
                }
            }
            return true
        }



        private func dateRange(from start: Date, to end: Date) -> [Date] {
            var dates: [Date] = []
            let calendar = Calendar.current
            var current = calendar.startOfDay(for: start)
            let endDate = calendar.startOfDay(for: end)

            while current <= endDate {
                dates.append(current)
                current = calendar.date(byAdding: .day, value: 1, to: current)!
            }

            return dates
        }
        
        




    }
