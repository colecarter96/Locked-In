//
//  ContentView.swift
//  Locked In
//
//  Created by Cole Carter on 8/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isRed = false
    
    var isCompletedToday = true
    
    @State private var selectedTab = 0
    
    var body: some View {
        
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
            
            
            
            
            Text("Mission Control")
                .font(.pretendard(fontStyle: .title2, fontWeight: .medium))
            
            ScrollView{
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.99, green: 0.99, blue: 0.99))
                        .frame(height: 150)
                    
                    Text("UnLocked")
                        .font(.pretendard(fontStyle: .subheadline, fontWeight: .regular))
                        .foregroundColor(Color.gray)
                        .padding(13)
                    
                    Text("Read 30 Mins")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                        .padding(13)
                        .padding(.vertical, 25)
                    
                    Text("Daily")
                        .font(.pretendard(fontStyle: .headline, fontWeight: .medium))
                        .padding(13)
                        .padding(.vertical, 50)
                    
                    Text("Streak")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(13)
                    
                    Text("3")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(13)
                        .padding(.horizontal, 70)
                    
                    
                    Button(action: {
                        //                                showingEditForm = true
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(13)
                        // Small fixed frame for tap area roughly the icon size
                        //                        .frame(width: 44, height: 44)
                    }
                    
                }
                .frame(height: 150)
                .padding(.horizontal, 30)
                .padding(.top, 5)
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.99, green: 0.99, blue: 0.99))
                        .frame(height: 150)
                    
                    Text("UnLocked")
                        .font(.pretendard(fontStyle: .subheadline, fontWeight: .regular))
                        .foregroundColor(Color.gray)
                        .padding(13)
                    
                    Text("Read 30 Mins")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                        .padding(13)
                        .padding(.vertical, 25)
                    
                    Text("Daily")
                        .font(.pretendard(fontStyle: .headline, fontWeight: .medium))
                        .padding(13)
                        .padding(.vertical, 50)
                    
                    Text("Streak")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(13)
                    
                    Text("3")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(13)
                        .padding(.horizontal, 70)
                    
                    
                    Button(action: {
                        //                                showingEditForm = true
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black)
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(13)
                        // Small fixed frame for tap area roughly the icon size
                        //                        .frame(width: 44, height: 44)
                    }
                    
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack{
                                Circle()
                                    .fill(Color.black) // or whatever style
                                    .frame(width: 70, height: 70)
                                    .padding(13) // spacing from edges
                                Text("Lock")
                                    .font(.pretendard(fontStyle: .body, fontWeight: .medium))
                                    .foregroundStyle(.white)
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
                .padding(.top, 5)
            }
            .frame(height: UIScreen.main.bounds.height * 0.56) // about 3/5ths
            
            
            
//            ControlsView(daysLocked: "0", lockGoal: "\(habit.streakGoal)")
            // Bottom Section
            VStack (spacing: 0){
                
                
                Rectangle()
                    .fill(Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
                    .frame(height: 2)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                
                HStack {
                    
                    GeometryReader { geo in
                        ZStack{
                            Circle()
                                .fill(isCompletedToday ? .red : Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0))
                                .frame(width: geo.size.width * 0.85, height: geo.size.width * 0.85) // limit max size if you want
                                .position(x: geo.size.width / 2, y: geo.size.height / 2) // center the circle inside its geometry reader
                                .padding(.bottom, 10)
                                .onTapGesture {
                                    isRed.toggle()
                                    
//                                    let calendar = Calendar.current
//                                    let today = calendar.startOfDay(for: Date())
//
//                                    if habit.history[today] == true {
//                                        // Uncheck: remove today's entry
//                                        habit.history.removeValue(forKey: today)
//                                    } else {
//                                        // Check: mark today as complete
//                                        habit.history[today] = true
//                                    }
//
//                                    // Notify parent
//                                    onUpdate(habit)
//
//                                    let generator = UIImpactFeedbackGenerator(style: .medium)
//                                    generator.impactOccurred()
                                    
    //                                lockedIn.toggle()
                                }
                            
                            Text(isCompletedToday ? "UnLock" : "Lock")
                                .font(.pretendard(fontStyle: .title3, fontWeight: .semibold))
                                .foregroundColor(Color.white)
                        }
                        
                            
                    }
                    .frame(minWidth: 0, maxWidth: .infinity) // take up all left space
                    
                    
                    Rectangle()
                        .fill(Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                    
                    
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
//                                showingEditForm = true
                            }) {
                                Image(systemName: "plus")
                                    .foregroundStyle(.black)
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
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    
                }
                .ignoresSafeArea()
                
            }
            
        }
        
        .background(Color(red: 0.90, green: 0.90, blue: 0.90, opacity: 1.0))
        
        

        
        
    }
}

#Preview {
    ContentView()
}
