//
//  HabitView.swift
//  Locked In
//
//  Created by Cole Carter on 8/4/25.
//

import SwiftUI

struct HabitView: View{
    
    @State private var isRed = false
    
    @State private var showingEditForm = false
    
  

    
    // Lock Box vars
    var statusText: String
    
//    var habit: Habit
    
//    @State var habit: Habit
    
    @Binding var habit: Habit
    
    var onUpdate: (Habit) -> Void
    var onDelete: (Habit) -> Void
    


    
    
    var body: some View{
        
        let habitStreak = getHabitStreak(for: habit)
        let today = Date()
        let isCompletedToday = habit.history.keys.contains {
            Calendar.current.isDate($0, inSameDayAs: today)
        }
        
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
            
            LockCardView(statusText: (isCompletedToday ? "LockedIn" : "UnLocked"), titleText: "Habit", subtitleText: habit.name)
            
            
            // Habit Type Side by Side
            HabitStreakView(habitType: habit.frequency.displayName, currStreak: "\(habitStreak)")
            
            
//            ControlsView(daysLocked: "0", lockGoal: "\(habit.streakGoal)")
            // Bottom Section
            VStack (spacing: 0){
                HStack(alignment: .lastTextBaseline){
                    Text("Days Locked")
                        .font(.pretendard(fontStyle: .headline, fontWeight: .semibold))
                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
                    Text("0")
                        .padding(.trailing, 20)
                        .font(.pretendard(size: 44, weight: .regular))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0))
                    Text("Lock Goal")
                        .padding(.leading, 20)
                        .font(.pretendard(fontStyle: .headline, fontWeight: .semibold))
                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
                    Text("\(habit.streakGoal)")
                        .font(.pretendard(size: 64, weight: .regular))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0))
                    
                }
                .padding(.bottom, 0)
                
                Rectangle()
                    .fill(Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
                    .frame(height: 2)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                
                HStack {
                    
                    GeometryReader { geo in
                        ZStack{
                            Circle()
                                .fill(isRed ? .red : Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0))
                                .frame(width: geo.size.width * 0.85, height: geo.size.width * 0.85) // limit max size if you want
                                .position(x: geo.size.width / 2, y: geo.size.height / 2) // center the circle inside its geometry reader
                                .padding(.bottom, 10)
                                .onTapGesture {
                                    isRed.toggle()
                                    
                                    let calendar = Calendar.current
                                    let today = calendar.startOfDay(for: Date())

                                    if habit.history[today] == true {
                                        // Uncheck: remove today's entry
                                        habit.history.removeValue(forKey: today)
                                    } else {
                                        // Check: mark today as complete
                                        habit.history[today] = true
                                    }

                                    // Notify parent
                                    onUpdate(habit)

                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                    
    //                                lockedIn.toggle()
                                }
                            
                            Text("Lock")
                                .font(.pretendard(fontStyle: .title3, fontWeight: .semibold))
                                .foregroundColor(Color.white)
                        }
                        
                            
                    }
                    .frame(minWidth: 0, maxWidth: .infinity) // take up all left space
                    
                    
                    Rectangle()
                        .fill(Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                    
                    
                    GeometryReader { geo in
                        Button(action:  {
                            showingEditForm = true
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.black)
                                .font(.largeTitle)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2) // center the image inside geometry reader
                        }
                        .sheet(isPresented: $showingEditForm) {
//                            AddHabitFormView(habitToEdit: habit) { updatedHabit in
//                                print("Habit returned \(updatedHabit.name)")
//                                habit = updatedHabit
//                                showingEditForm = false
//                            }
                            
//                            AddHabitFormView(habitToEdit: habit, onSubmit: { updatedHabit in
//                                habit = updatedHabit
//                                onUpdate(updatedHabit)
//                                showingEditForm = false
//                            }, onDelete: {
//                                // Remove habit from wherever you're storing it
//                                print("Habit deleted")
//                                onDelete(habit)
//                                showingEditForm = false
//                            })
                            AddHabitFormView(
                                habitToEdit: habit,
                                onSubmit: { updatedHabit in
                                    onUpdate(updatedHabit)   // Triggers update in parent
                                    showingEditForm = false
                                },
                                onDelete: {
                                    onDelete(habit)          // Triggers delete in parent
                                    showingEditForm = false
                                }
                            )
                        }
                        
//
                    }
                    .frame(minWidth: 0, maxWidth: .infinity) // take up all right space
                }
                .ignoresSafeArea()
                
            }
            
        }
        
        .background(Color(red: 0.90, green: 0.90, blue: 0.90, opacity: 1.0))

    }
    
    func getHabitStreak(for habit: Habit) -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var streak = 0

        for offset in 0..<365 {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { break }

            let completed = habit.history.contains { key, value in
                value && calendar.isDate(key, inSameDayAs: date)
            }

            if completed {
                streak += 1
            } else {
                break
            }
        }

        return streak
    }

}


//
//struct HabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitView(statusText: "UnLocked", habitTitle: "Read 30 Mins",
//                  habitType: "Daily", currStreak: "0", daysLocked: "9", lockGoal: "67")
//    }
//}


//
//import SwiftUI
//
//struct HabitView: View{
//    
//    @State private var isRed = false
//    
//    // Lock Box vars
//    var statusText: String
//    var habitTitle: String
//    
//    // Habit/Streak Box vars
//    var habitType: String
//    var currStreak: String
//    
//    var daysLocked: String
//    var lockGoal: String
//
//    
//    
//    var body: some View{
//        VStack (){
//            
//            // Top Circles
//            HStack (spacing: 90) {
//                Circle()
//                    .fill(Color.gray)
//                    .frame(width: 8, height: 8)
//                Circle()
//                    .fill(Color.black)
//                    .frame(width: 8, height: 8)
//                
//            }
//            .padding(.vertical, 16)
//            
//            LockCardView(statusText: statusText, titleText: "Habit", subtitleText: habitTitle)
//            
//            
//            // Habit Type Side by Side
//            HabitStreakView(habitType: "Daily", currStreak: "0")
//            
//            
//            ControlsView(daysLocked: daysLocked, lockGoal: lockGoal)
//            
//        }
//        .background(Color(red: 0.90, green: 0.90, blue: 0.90, opacity: 1.0))
//
//    }
//}
//
//
//
//struct HabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitView(statusText: "UnLocked", habitTitle: "Read 30 Mins",
//                  habitType: "Daily", currStreak: "0", daysLocked: "9", lockGoal: "67")
//    }
//}
