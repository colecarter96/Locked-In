//
//  HabitStore.swift
//  Locked In
//
//  Created by Cole Carter on 8/8/25.
//

import Foundation

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []

    private let saveKey = "SavedHabits.json"

    init() {
        loadHabits()
    }

    // MARK: - Load from File
    func loadHabits() {
        let url = getDocumentsDirectory().appendingPathComponent(saveKey)
        guard let data = try? Data(contentsOf: url) else {
            print("No saved habits found.")
            return
        }

        do {
            let decoded = try JSONDecoder().decode([Habit].self, from: data)
            self.habits = decoded
            print("Habits loaded successfully.")
        } catch {
            print("Failed to decode habits: \(error)")
        }
    }

    // MARK: - Save to File
    func saveHabits() {
        let url = getDocumentsDirectory().appendingPathComponent(saveKey)

        do {
            let data = try JSONEncoder().encode(habits)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            print("Habits saved successfully.")
        } catch {
            print("Failed to save habits: \(error)")
        }
    }

    // MARK: - CRUD
    func addHabit(_ habit: Habit) {
        habits.append(habit)
        saveHabits()
    }

    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        saveHabits()
    }
    
    //Deleting based on id:
//    func deleteHabit(_ habit: Habit) {
//        habits.removeAll { $0.id == habit.id }
//        saveHabits()
//    }

    // MARK: - Helper
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func toggleCompletion(for habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let completed = habits[index].history[today] {
            habits[index].history[today] = !completed
        } else {
            habits[index].history[today] = true
        }

        saveHabits()
    }
}
