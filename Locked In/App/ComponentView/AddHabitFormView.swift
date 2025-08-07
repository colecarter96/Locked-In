//
//  AddHabitFormView.swift
//  Locked In
//
//  Created by Cole Carter on 8/6/25.
//
//




//import SwiftUI
//
//struct AddHabitFormView: View {
//
//    var habitToEdit: Habit?
//    var onSubmit: (Habit) -> Void
//    //var onDelete: (() -> Void)? = nil
//
//    @State private var name: String = ""
//    @State private var streakGoal: Int = 28
//    @State private var selectedFrequency: FrequencyType = .daily
//    @State private var customDays: Set<Weekday> = []
//
//    //var onSave: (Habit) -> Void
//
////    init(habitToEdit: Habit? = nil, onSave: @escaping (Habit) -> Void) {
////        self.habitToEdit = habitToEdit
////        _name = State(initialValue: habitToEdit?.name ?? "")
////        _emoji = State(initialValue: habitToEdit?.emoji ?? "")
////        _goal = State(initialValue: habitToEdit?.goal ?? 1)
////        _frequency = State(initialValue: habitToEdit?.frequency ?? [])
////        self.onSave = onSave
////    }
//
//    var body: some View {
//        NavigationView {
//            Form {
//                // MARK: - Habit Name & Streak Goal
//                Section {
//                    TextField("Habit Name", text: $name)
//                        .font(.pretendard(fontStyle: .headline, fontWeight: .regular))
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text("Streak Goal (days)")
//                            .font(.pretendard(fontStyle: .headline, fontWeight: .regular))
//
//                        Picker("Streak Goal", selection: $streakGoal) {
//                            ForEach(28...99, id: \.self) { number in
//                                Text("\(number)")
//                            }
//                        }
//                        .pickerStyle(.wheel)
//                        .frame(maxHeight: 80) // Optional: limits height of wheel picker
//                    }
//
//                } header: {
//                    Text("Habit Details")
//                        .font(.pretendard(fontStyle: .footnote, fontWeight: .regular))
//                }
//
//                // MARK: - Frequency Picker
//                Section {
//                    Picker("Frequency", selection: $selectedFrequency) {
//                        ForEach(FrequencyType.allCases, id: \.self) { freq in
//                            Text(freq.displayName).tag(freq)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//
//                    if selectedFrequency == .custom {
//                        VStack(alignment: .leading) {
//                            Text("Select Days:")
//                            ForEach(Weekday.allCases, id: \.rawValue) { day in
//                                Toggle(isOn: Binding(
//                                    get: { customDays.contains(day) },
//                                    set: { isSelected in
//                                        if isSelected {
//                                            customDays.insert(day)
//                                        } else {
//                                            customDays.remove(day)
//                                        }
//                                    }
//                                )) {
//                                    Text(day.displayName)
//                                        .font(.pretendard(fontStyle: .body, fontWeight: .regular))
//                                }
//                                .tint(.red)
//
//                            }
//                        }
//                        .padding(.top, 8)
//                    }
//                } header: {
//                    Text("Frequency")
//                }
//
//                // MARK: - Submit Button
//                //Ask chat about dynamic save/update button
//                Section {
//                    Button(action: {
//                        let frequency: Habit.Frequency
//                        switch selectedFrequency {
//                        case .daily:
//                            frequency = .daily
//                        case .everyOtherDay:
//                            frequency = .everyOtherDay
//                        case .custom:
//                            frequency = .custom(Array(customDays))
//                        }
//
//                        let newHabit = Habit(
//                            // id: habitToEdit?.id ?? UUID()
//                            id: UUID(),
//                            name: name,
//                            streakGoal: streakGoal,
//                            frequency: frequency,
//                            history: [:]
//                        )
//
//                        onSubmit(newHabit)
//                    }) {
//                        Text(habitToEdit == nil ? "Add Habit" : "Save Changes")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(name.isEmpty || (selectedFrequency == .custom && customDays.isEmpty) ? Color.gray : Color.red)
//                            .cornerRadius(12)
//                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
//                    }
//                    .disabled(name.isEmpty || (selectedFrequency == .custom && customDays.isEmpty))
//                }
//            }
//            .navigationTitle(Text(habitToEdit == nil ? "Add Habit" : "Save Changes"))
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
////                        isPresented = false
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button(habitToEdit == nil ? "Add" : "Save") {
//                        let frequency: Frequency
//                        switch selectedFrequency {
//                        case .daily:
//                            frequency = .daily
//                        case .everyOtherDay:
//                            frequency = .everyOtherDay
//                        case .custom:
//                            frequency = .custom(Array(customDays))
//                        }
//
//                        let newHabit = Habit(
//                            id: habitToEdit?.id ?? UUID(),
//                            name: name,
//                            streakGoal: streakGoal,
//                            frequency: frequency,
//                            history: habitToEdit?.history ?? [:]
//                        )
//
////                        if let index = habits.firstIndex(where: { $0.id == newHabit.id }) {
//////                            habits[index] = newHabit // edit
////                        } else {
//////                            habits.append(newHabit) // new
////                        }
//
//                        isPresented = false
//                    }
//                }
//            }
//            .onAppear {
//                if let habit = habitToEdit, !hasLoadedExistingHabit {
//                    name = habit.name
//                    streakGoal = habit.streakGoal
//
//                    switch habit.frequency {
//                    case .daily:
//                        selectedFrequency = .daily
//                    case .everyOtherDay:
//                        selectedFrequency = .everyOtherDay
//                    case .custom(let days):
//                        selectedFrequency = .custom
//                        customDays = Set(days)
//                    }
//
//                    hasLoadedExistingHabit = true
//                }
//            }
//        }
//    }
//
//    private func toggleDay(_ day: Weekday) {
//        if customDays.contains(day) {
//            customDays.remove(day)
//        } else {
//            customDays.insert(day)
//        }
//    }
//
//    // UI-level enum for Picker
//    enum FrequencyType: String, CaseIterable {
//        case daily, everyOtherDay, custom
//
//        var displayName: String {
//            switch self {
//            case .daily: return "Daily"
//            case .everyOtherDay: return "Every Other Day"
//            case .custom: return "Custom"
//            }
//        }
//    }
//}



import SwiftUI

struct AddHabitFormView: View {
    
    var habitToEdit: Habit?
    var onSubmit: (Habit) -> Void
    var onDelete: (() -> Void)? = nil
    
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var streakGoal: Int = 28
    @State private var selectedFrequency: FrequencyType = .daily
    @State private var customDays: Set<Weekday> = []
    
    //var onSave: (Habit) -> Void
    
//    init(habitToEdit: Habit? = nil, onSave: @escaping (Habit) -> Void) {
//        self.habitToEdit = habitToEdit
//        _name = State(initialValue: habitToEdit?.name ?? "")
//        _emoji = State(initialValue: habitToEdit?.emoji ?? "")
//        _goal = State(initialValue: habitToEdit?.goal ?? 1)
//        _frequency = State(initialValue: habitToEdit?.frequency ?? [])
//        self.onSave = onSave
//    }

    var body: some View {
        NavigationView {
            Form {
                // MARK: - Habit Name & Streak Goal
                Section {
                    TextField("Habit Name", text: $name)
                        .font(.pretendard(fontStyle: .headline, fontWeight: .regular))
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Streak Goal (days)")
                            .font(.pretendard(fontStyle: .headline, fontWeight: .regular))

                        Picker("Streak Goal", selection: $streakGoal) {
                            ForEach(28...99, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxHeight: 80) // Optional: limits height of wheel picker
                    }

                } header: {
                    Text("Habit Details")
                        .font(.pretendard(fontStyle: .footnote, fontWeight: .regular))
                }

                // MARK: - Frequency Picker
                Section {
                    Picker("Frequency", selection: $selectedFrequency) {
                        ForEach(FrequencyType.allCases, id: \.self) { freq in
                            Text(freq.displayName).tag(freq)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if selectedFrequency == .custom {
                        VStack(alignment: .leading) {
                            Text("Select Days:")
                            ForEach(Weekday.allCases, id: \.rawValue) { day in
                                Toggle(isOn: Binding(
                                    get: { customDays.contains(day) },
                                    set: { isSelected in
                                        if isSelected {
                                            customDays.insert(day)
                                        } else {
                                            customDays.remove(day)
                                        }
                                    }
                                )) {
                                    Text(day.displayName)
                                        .font(.pretendard(fontStyle: .body, fontWeight: .regular))
                                }
                                .tint(.red)
                                
                            }
                        }
                        .padding(.top, 8)
                    }
                } header: {
                    Text("Frequency")
                }

                // MARK: - Submit Button
                //Ask chat about dynamic save/update button
                Section {
                    Button(action: {
                        let frequency: Habit.Frequency
                        switch selectedFrequency {
                        case .daily:
                            frequency = .daily
                        case .everyOtherDay:
                            frequency = .everyOtherDay
                        case .custom:
                            frequency = .custom(Array(customDays))
                        }

                        let newHabit = Habit(
                             id: habitToEdit?.id ?? UUID(),
//                            id: UUID(),
                            name: name,
                            streakGoal: streakGoal,
                            frequency: frequency,
                            history: [:]
                        )

                        onSubmit(newHabit)
                        dismiss() //feel like I might not need this
                    }) {
                        Text(habitToEdit == nil ? "Add Habit" : "Save Changes")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(name.isEmpty || (selectedFrequency == .custom && customDays.isEmpty) ? Color.gray : Color.red)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .disabled(name.isEmpty || (selectedFrequency == .custom && customDays.isEmpty))
                }
                
                if habitToEdit != nil {
                    Section {
                        Button(role: .destructive) {
                            // Call the delete callback when tapped
                            onDelete?()
                        } label: {
                            Text("Delete Habit")
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle(Text(habitToEdit == nil ? "Add Habit" : "Save Changes"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let habit = habitToEdit {
                    name = habit.name
                    streakGoal = habit.streakGoal
                    
                    switch habit.frequency {
                    case .daily:
                        selectedFrequency = .daily
                        customDays = []
                    case .everyOtherDay:
                        selectedFrequency = .everyOtherDay
                        customDays = []
                    case .custom(let days):
                        selectedFrequency = .custom
                        customDays = Set(days)
                    }
                }
                
            }
        }
    }

    private func toggleDay(_ day: Weekday) {
        if customDays.contains(day) {
            customDays.remove(day)
        } else {
            customDays.insert(day)
        }
    }

    // UI-level enum for Picker
    enum FrequencyType: String, CaseIterable {
        case daily, everyOtherDay, custom

        var displayName: String {
            switch self {
            case .daily: return "Daily"
            case .everyOtherDay: return "Every Other Day"
            case .custom: return "Custom"
            }
        }
    }
}


struct AddHabitFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitFormView { habit in
            print("Habit created: \(habit)")
        }
    }
}

//
//
//import SwiftUI
//
//struct AddHabitFormView: View {
//    
//    //var habitToEdit: Habit?
//    
//    var onSubmit: (Habit) -> Void
//
//    @State private var name: String = ""
//    @State private var streakGoal: Int = 28
//    @State private var selectedFrequency: FrequencyType = .daily
//    @State private var customDays: Set<Weekday> = []
//    
//    //var onSave: (Habit) -> Void
//    
////    init(habitToEdit: Habit? = nil, onSave: @escaping (Habit) -> Void) {
////        self.habitToEdit = habitToEdit
////        _name = State(initialValue: habitToEdit?.name ?? "")
////        _emoji = State(initialValue: habitToEdit?.emoji ?? "")
////        _goal = State(initialValue: habitToEdit?.goal ?? 1)
////        _frequency = State(initialValue: habitToEdit?.frequency ?? [])
////        self.onSave = onSave
////    }
//
//    var body: some View {
//        NavigationView {
//            Form {
//                // MARK: - Habit Name & Streak Goal
//                Section {
//                    TextField("Habit Name", text: $name)
//                        .font(.pretendard(fontStyle: .headline, fontWeight: .regular))
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text("Streak Goal (days)")
//                            .font(.pretendard(fontStyle: .headline, fontWeight: .regular))
//
//                        Picker("Streak Goal", selection: $streakGoal) {
//                            ForEach(28...99, id: \.self) { number in
//                                Text("\(number)")
//                            }
//                        }
//                        .pickerStyle(.wheel)
//                        .frame(maxHeight: 80) // Optional: limits height of wheel picker
//                    }
//
//                } header: {
//                    Text("Habit Details")
//                        .font(.pretendard(fontStyle: .footnote, fontWeight: .regular))
//                }
//
//                // MARK: - Frequency Picker
//                Section {
//                    Picker("Frequency", selection: $selectedFrequency) {
//                        ForEach(FrequencyType.allCases, id: \.self) { freq in
//                            Text(freq.displayName).tag(freq)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//
//                    if selectedFrequency == .custom {
//                        VStack(alignment: .leading) {
//                            Text("Select Days:")
//                            ForEach(Weekday.allCases, id: \.rawValue) { day in
//                                Toggle(isOn: Binding(
//                                    get: { customDays.contains(day) },
//                                    set: { isSelected in
//                                        if isSelected {
//                                            customDays.insert(day)
//                                        } else {
//                                            customDays.remove(day)
//                                        }
//                                    }
//                                )) {
//                                    Text(day.displayName)
//                                        .font(.pretendard(fontStyle: .body, fontWeight: .regular))
//                                }
//                                .tint(.red)
//                                
//                            }
//                        }
//                        .padding(.top, 8)
//                    }
//                } header: {
//                    Text("Frequency")
//                }
//
//                // MARK: - Submit Button
//                //Ask chat about dynamic save/update button
//                Section {
//                    Button(action: {
//                        let frequency: Habit.Frequency
//                        switch selectedFrequency {
//                        case .daily:
//                            frequency = .daily
//                        case .everyOtherDay:
//                            frequency = .everyOtherDay
//                        case .custom:
//                            frequency = .custom(Array(customDays))
//                        }
//
//                        let newHabit = Habit(
//                            // id: habitToEdit?.id ?? UUID()
//                            id: UUID(),
//                            name: name,
//                            streakGoal: streakGoal,
//                            frequency: frequency,
//                            history: [:]
//                        )
//
//                        onSubmit(newHabit)
//                    }) {
//                        Text("Add Habit")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(name.isEmpty || (selectedFrequency == .custom && customDays.isEmpty) ? Color.gray : Color.red)
//                            .cornerRadius(12)
//                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
//                    }
//                    .disabled(name.isEmpty || (selectedFrequency == .custom && customDays.isEmpty))
//                }
//            }
//            .navigationTitle("New Habit")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//
//    private func toggleDay(_ day: Weekday) {
//        if customDays.contains(day) {
//            customDays.remove(day)
//        } else {
//            customDays.insert(day)
//        }
//    }
//
//    // UI-level enum for Picker
//    enum FrequencyType: String, CaseIterable {
//        case daily, everyOtherDay, custom
//
//        var displayName: String {
//            switch self {
//            case .daily: return "Daily"
//            case .everyOtherDay: return "Every Other Day"
//            case .custom: return "Custom"
//            }
//        }
//    }
//}
