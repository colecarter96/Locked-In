//
//  MissionControl.swift
//  Locked In
//
//  Created by Cole Carter on 8/13/25.
//

import SwiftUI

struct MissionControlView: View {
    
    @EnvironmentObject var habitStore: HabitStore
    
    @EnvironmentObject var themeManager: ThemeManager

    
//    @State private var isRed = false
    
    var onAddHabit: (Habit) -> Void

    @State private var showingAddForm = false
    
//    @State private var showingEditForm = false
    
    @Binding var selectedTab: Int
    
    
    
    var body: some View {
        
        let calendar = Calendar.current
        let allLockedIn = !habitStore.habits.isEmpty && habitStore.habits.allSatisfy { $0.isCompletedToday }
        
        VStack (){
            
            // Top Circles
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
            
            CirclesNavView(currTab: $selectedTab, totalPages: 5)
            
            
            
            
//            Text("Mission Control")
//                .font(.pretendard(fontStyle: .title2, fontWeight: .medium))
            
            
            
            
            ScrollView {
                
                ZStack (alignment: .topLeading){
                    RoundedRectangle(cornerRadius: 20)
                        .fill(themeManager.cardColor)
                        .frame(height: 200)
                    
                    Text("LockedIn")
                        .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                        .foregroundColor(themeManager.habitStatus)
                        .padding(15)
                    
        //            Rectangle()
        //                .frame(width: 200, height: 200)
    //                Image("LockTemp")
    //                    .resizable()
    //                    .frame(width: 133.33, height: 200)
    //                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("Mission Control")
                            .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                            .foregroundStyle(themeManager.textColor)
                
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(15)
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: themeManager.isLightMode ? "chevron.down" : "diamond")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(themeManager.textColor)
                            .onTapGesture {
                                themeManager.isLightMode.toggle()
                            }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(15)
                }
                .padding(.horizontal, 30)
                .frame(height: 200)
                
                ForEach($habitStore.habits) { $hab in   // 👈 $hab is a Binding<Habit>
                    HabitRowView(
                        habit: $hab, // 👈 Pass the binding
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
                
            }
            .frame(height: UIScreen.main.bounds.height * 0.6) // about 3/5ths
            .padding(.bottom, 0)
            
            
            
//            ControlsView(daysLocked: "0", lockGoal: "\(habit.streakGoal)")
            // Bottom Section
            VStack (spacing: 0){
                
                
                Rectangle()
                    .fill(themeManager.controlRect)
                    .frame(height: 2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(0)
                
                
                
                HStack {
                    
                    GeometryReader { geo in
                        ZStack{
                            Circle()
                                .fill(allLockedIn ? .red : themeManager.lockButton)
                                .frame(width: geo.size.width * 0.85, height: geo.size.width * 0.85) // limit max size if you want
                                .position(x: geo.size.width / 2, y: geo.size.height / 2) // center the circle inside its geometry reader
                                .padding(.bottom, 10)
                                .onTapGesture {
////                                    let calendar = Calendar.current
//                                    let today = calendar.startOfDay(for: Date())
//                                    
//                                    // Mark all habits as completed today
//                                    for index in habitStore.habits.indices {
//                                        if habitStore.habits[index].history[today] == true {
//                                            // Uncheck: remove today's entry
//                                            habitStore.habits[index].history.removeValue(forKey: today)
//                                        } else {
//                                            // Check: mark today as complete
//                                            habitStore.habits[index].history[today] = true
//                                        }
////                                        habitStore.habits[index].history[today] = true
//                                    }
//                                    
//                                    // Save changes
//                                    habitStore.saveHabits()
//                                    
//                                    // Optional: haptic feedback
//                                    let generator = UIImpactFeedbackGenerator(style: .medium)
//                                    generator.impactOccurred()
                                    let today = calendar.startOfDay(for: Date())
                                        
                                    // Step 1: Decide action — if ALL are locked in, then we unlock; otherwise lock all
                                    let shouldUnlock = habitStore.habits.allSatisfy { $0.history[today] == true }
                                    
                                    // Step 2: Apply the same action to every habit
                                    for index in habitStore.habits.indices {
                                        if shouldUnlock {
                                            // Remove today's entry for all
                                            habitStore.habits[index].history.removeValue(forKey: today)
                                        } else {
                                            // Mark all as complete
                                            habitStore.habits[index].history[today] = true
                                        }
                                    }
                                    
                                    // Save changes
                                    habitStore.saveHabits()
                                    
                                    // Haptic feedback
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                }
                            
                            Text(allLockedIn ? "UnLock\nAll" : "Lock\nAll")
                                .font(.pretendard(fontStyle: .title3, fontWeight: .semibold))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .allowsHitTesting(false)
                            
                        }
                        
                            
                    }
                    .frame(minWidth: 0, maxWidth: .infinity) // take up all left space
                    
                    
                    Rectangle()
                        .fill(themeManager.controlRect)
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                        .padding(.top, 0)
                    
                    
//                    GeometryReader { geo in
//                        Button(action:  {
//                            showingEditForm = true
//                        }) {
//                            Image(systemName: "ellipsis")
//                                .foregroundStyle(.black)
//                                .font(.largeTitle)
//                                .position(x: geo.size.width / 2, y: geo.size.height / 2) // center the image inside geometry reader
//                        }
//                        .sheet(isPresented: $showingEditForm) {
////                            AddHabitFormView(habitToEdit: habit) { updatedHabit in
////                                print("Habit returned \(updatedHabit.name)")
////                                habit = updatedHabit
////                                showingEditForm = false
////                            }
//
////                            AddHabitFormView(habitToEdit: habit, onSubmit: { updatedHabit in
////                                habit = updatedHabit
////                                onUpdate(updatedHabit)
////                                showingEditForm = false
////                            }, onDelete: {
////                                // Remove habit from wherever you're storing it
////                                print("Habit deleted")
////                                onDelete(habit)
////                                showingEditForm = false
////                            })
//                            AddHabitFormView(
//                                habitToEdit: habit,
//                                onSubmit: { updatedHabit in
//                                    onUpdate(updatedHabit)   // Triggers update in parent
//                                    showingEditForm = false
//                                },
//                                onDelete: {
//                                    onDelete(habit)          // Triggers delete in parent
//                                    showingEditForm = false
//                                }
//                            )
//                        }
//
////
//                    }
//                    .frame(minWidth: 0, maxWidth: .infinity) // take up all right space
////
                    GeometryReader { geo in
                        ZStack {
                            Button(action: {
                                showingAddForm = true
                            }) {
                                Image(systemName: "plus")
                                    .foregroundStyle(themeManager.textColor)
                                    .font(.largeTitle)
                                    // Small fixed frame for tap area roughly the icon size
                                    .frame(width: 44, height: 44)
                            }
//                            .sheet(isPresented: $showingEditForm) {
//                                AddHabitFormView(
//                                    habitToEdit: habit,
//                                    onSubmit: { updatedHabit in
//                                        onUpdate(updatedHabit)   // Triggers update in parent
//                                        showingEditForm = false
//                                    },
//                                    onDelete: {
//                                        onDelete(habit)          // Triggers delete in parent
//                                        showingEditForm = false
//                                    }
//                                )
//                            }
//                            .contentShape(Rectangle())  // hit testing limited to this frame
//                            // Center the button inside the GeometryReader
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                            .sheet(isPresented: $showingAddForm) {
                                AddHabitFormView { newHabit in
                                    onAddHabit(newHabit)
                                    showingAddForm = false
                                }
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    

                    
                    
                }
                .ignoresSafeArea()
                .padding(.top, 0)
                
            }
            
        }
        .background(themeManager.backgroundColor)
        
        

        
        
    }
}

//struct MissionControlView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionControlView()
//            .environmentObject(HabitStore()) // Required for preview
//    }
//}
//
