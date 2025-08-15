//
//  HabitRow.swift
//  Locked In
//
//  Created by Cole Carter on 8/13/25.
//

import SwiftUI

struct HabitRowView: View {
    
    @Binding var habit: Habit
    
    @State private var showingEditForm = false
    
    @EnvironmentObject var themeManager : ThemeManager
    
    var onUpdate: (Habit) -> Void
    var onDelete: (Habit) -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(themeManager.cardColor)
                .frame(height: 150)
            
            Text(habit.isCompletedToday ? "LockedIn" : "UnLocked")
                .font(.pretendard(fontStyle: .subheadline, fontWeight: .regular))
                .foregroundColor(themeManager.habitStatus)
                .padding(13)
                .foregroundStyle(.black)
            
            Text("\(habit.name)")
                .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                .padding(13)
                .padding(.vertical, 25)
                .foregroundStyle(themeManager.textColor)
            
            Text("\(habit.frequency.displayName)")
                .font(.pretendard(fontStyle: .headline, fontWeight: .medium))
                .padding(13)
                .padding(.vertical, 50)
                .foregroundStyle(themeManager.textColor)
            
            Text("Streak - \(habit.streak)")
                .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                .foregroundStyle(themeManager.textColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(13)
                .foregroundStyle(themeManager.textColor)
            
//            Text("\(habit.streak)")
//                .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
//                .foregroundStyle(.black)
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//                .padding(13)
//                .padding(.horizontal, 70)
//                .foregroundStyle(.black)
            
            HStack{
                Spacer()
                
                Button(action: {
                    showingEditForm = true
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(themeManager.textColor)
                        .font(.title)
                        .frame(width: 44, height: 44)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing, 5)
                    // Small fixed frame for tap area roughly the icon size
                    //                        .frame(width: 44, height: 44)
                }
                .sheet(isPresented: $showingEditForm) {
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
            }
            
           

            
            
            
            
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack{
                        Circle()
                            .fill(habit.isCompletedToday ? .red : themeManager.lockButton) // or whatever style
                            .frame(width: 75, height: 75)
                            .padding(13) // spacing from edges
                            .onTapGesture {
            //                                    isRed.toggle()
                                
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
                        Text(habit.isCompletedToday ? "UnLock" : "Lock")
                            .font(.pretendard(fontStyle: .subheadline, fontWeight: .medium))
                            .foregroundStyle(.white)
                            .allowsHitTesting(false)
                    }
                    
                }
            }
            .frame(maxHeight: .infinity)
            
//                    ZStack{
//                        Circle()
//                            .foregroundStyle(.black)
//                            .font(.largeTitle)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
//                            .padding(13)
//
//                        Text("Lock")
//                            .frame(alignment: .center)
//                    }
            
        }
        .frame(height: 150)
        .padding(.horizontal, 30)
//        .padding(.top, 5)
    }
    
}


//
//struct HabitRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        HabitRowView()
//    }
//}
