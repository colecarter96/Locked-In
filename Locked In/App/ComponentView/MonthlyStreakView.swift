//
//  MonthlyStreakView.swift
//  Locked In
//
//  Created by Cole Carter on 8/5/25.
//

import SwiftUI

struct MonthlyStreakView: View {
    let dailyCompletionFlags: [Bool?] // nil = future day
    
    @EnvironmentObject var themeManager: ThemeManager


    func colorForCompletion(_ status: Bool?) -> Color {
        if let completed = status {
            return completed ? themeManager.textColor : Color.gray.opacity(0.3)
        } else {
            return Color.gray.opacity(0.1) // future day = faint gray
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(themeManager.cardColor)
                .frame(height: 300)

            Text("LockedIn")
                .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                .foregroundColor(themeManager.habitStatus)
                .padding(15)

            VStack {
                ForEach(0..<4, id: \.self) { weekIndex in
                    HStack(spacing: 0) {
                        ForEach(0..<7, id: \.self) { dayIndex in
                            let index = weekIndex * 7 + dayIndex
                            Circle()
                                .fill(dailyCompletionFlags.isEmpty ? Color.gray.opacity(0.1) : (index < dailyCompletionFlags.count ? colorForCompletion(dailyCompletionFlags[index]) : Color.gray.opacity(0.1)))
                                .frame(width: 40, height: 40)
                                .padding(.horizontal, 1)
                        }
                    }
                }
            }
            .padding(.top, 50)
            .padding(.leading, 20)

            VStack(alignment: .leading) {
                Text("Locked Streak")
                    .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    .foregroundColor(themeManager.textColor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(15)
        }
        .padding(.horizontal, 30)
    }
}

//
//struct MonthlyStreakView: View {
//    // Change input: daily flags for 28 days
//    let dailyCompletionFlags: [Bool]
//
//    func colorForCompletion(_ completed: Bool) -> Color {
//        completed ? Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0) : Color.gray.opacity(0.3)
//    }
//
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color(red: 0.99, green: 0.99, blue: 0.99))
//                .frame(height: 300)
//            
//            Text("LockedIn")
//               .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
//               .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
//               .padding(15)
//
//            VStack() {
//                ForEach(0..<4, id: \.self) { weekIndex in
//                    HStack(spacing: 0) {
//                        ForEach(0..<7, id: \.self) { dayIndex in
//                            let index = weekIndex * 7 + dayIndex
//                            Circle()
//                                .fill(index < dailyCompletionFlags.count ? colorForCompletion(dailyCompletionFlags[index]) : Color.gray.opacity(0.3))
//                                .frame(width: 40, height: 40)
//                                .padding(.horizontal, 1)
//                        }
//                    }
//                }
//            }
//            .padding(.top, 50)
//            .padding(.leading, 20)
//
//            VStack(alignment: .leading) {
//                Text("Locked Streak")
//                    .font(.pretendard(fontStyle: .title3, fontWeight: .regular))
//                    .foregroundColor(Color.black.opacity(0.8))
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//            .padding(15)
//        }
//        .padding(.horizontal, 30)
//    }
//}




//struct MonthlyStreakView: View {
//    let weekCompletionFlags: [Bool] // True if week was fully completed
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            ForEach(0..<4, id: \.self) { weekIndex in
//                HStack(spacing: 6) {
//                    ForEach(0..<7, id: \.self) { _ in
//                        Circle()
//                            .fill(weekCompletionFlags[weekIndex] ? Color.green : Color.gray.opacity(0.3))
//                            .frame(width: 12, height: 12)
//                    }
//                }
//            }
//        }
//        .padding(.horizontal)
//    }
//}


//
//struct MonthlyStreakView: View {
//    
//    var dailyArr = [1,1,1,1,1,1,1,
//                    1,1,1,1,1,1,1,
//                    1,1,1,1,1,1,1,
//                    1,0,0,0,0,0,0]
//    
//    func colorForStatus(_ status: Int) -> Color {
//        switch status{
//        case 1: return .black
//        case 0: return Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0)
//        default: return Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0)
//        }
//    }
//    
//    
//    
//    var body: some View{
//        ZStack (alignment: .topLeading){
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
//                .frame(height: 300)
//            
//            Text("LockedIn")
//                .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
//                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
//                .padding(15)
//            
//            VStack {
//                HStack (spacing: 0){
//                    ForEach(dailyArr.prefix(7), id: \.self) { status in
//                            Circle()
//                                .fill(colorForStatus(status))
//                                .frame(width: 40, height: 40)
//                                .padding(.horizontal, 1)
//                    }
//                   
//                }
//                
//                HStack (spacing: 0){
//                    let safeRange = 7..<min(dailyArr.count, 14)
//                    ForEach(Array(dailyArr[safeRange]), id: \.self) { status in
//                        Circle()
//                            .fill(colorForStatus(status))
//                            .frame(width: 40, height: 40)
//                            .padding(.horizontal, 1)
//                    }
//                   
//                }
//                
//                HStack (spacing: 0){
//                    let safeRange = 14..<min(dailyArr.count, 21)
//                    ForEach(Array(dailyArr[safeRange]), id: \.self) { status in
//                        Circle()
//                            .fill(colorForStatus(status))
//                            .frame(width: 40, height: 40)
//                            .padding(.horizontal, 1)
//                    }
//                   
//                }
//                
//                HStack (spacing: 0){
//                    ForEach(Array(dailyArr[21...]), id: \.self) { status in
//                        Circle()
//                            .fill(colorForStatus(status))
//                            .frame(width: 40, height: 40)
//                            .padding(.horizontal, 1)
//                }
//                        
//                    
//                   
//                }
//                
//                
//            }
//            .padding(.top, 50)
//            .padding(.leading, 20)
//            
//            
//            VStack(alignment: .leading, spacing: 0){
//                
//                Text("Locked Streak")
//                    .font(.pretendard(fontStyle: .title3, fontWeight: .regular))
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//            .padding(15)
//        }
//        .padding(.horizontal, 30)
//        .frame(height: 300)
//    }
//}
