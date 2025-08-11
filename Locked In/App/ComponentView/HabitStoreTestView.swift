//
//  HabitStoreTestView.swift
//  Locked In
//
//  Created by Cole Carter on 8/8/25.
//

import SwiftUI

struct HabitStoreTestView: View {
    @StateObject var store = HabitStore()

    var body: some View {
        VStack {
            List {
                ForEach(store.habits) { habit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            Text("Streak: \(habit.currentStreak) days")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                store.toggleCompletion(for: habit)
                            }
                    }
                }
                .onDelete(perform: store.deleteHabit)
            }

            Button("Add Sample Habit") {
                let newHabit = Habit(
                    id: UUID(),
                    name: "Habit \(store.habits.count + 1)",
                    streakGoal: 7,
                    frequency: .daily,
                    history: [:]
                )
                store.addHabit(newHabit)
            }
        }
        .padding()
    }
}




struct HabitStoreTestView_Previews: PreviewProvider {
    static var previews: some View {
        HabitStoreTestView()
    }
}

