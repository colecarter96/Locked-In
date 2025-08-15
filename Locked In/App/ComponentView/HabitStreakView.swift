//
//  Untitled.swift
//  Locked In
//
//  Created by Cole Carter on 8/4/25.
//

import SwiftUI

struct HabitStreakView: View{
    
    var habitType: String
    var currStreak: String
    
    @EnvironmentObject var themeManager : ThemeManager
    
    var body: some View{
        // Habit Type Side by Side
        HStack {
            ZStack (alignment: .topLeading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(themeManager.cardColor)
                    .frame(height: 150)
                
                Text("Habit Type")
                    .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                    .foregroundColor(themeManager.habitStatus)
                    .padding(13)
                
                Text(habitType)
                    .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    .foregroundStyle(themeManager.textColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(13)
            }
            .frame(height: 150)
            
            ZStack (alignment: .topLeading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(themeManager.cardColor)
                    .frame(height: 150)
                
                Text("Streak")
                    .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                    .foregroundColor(themeManager.habitStatus)
                    .padding(13)
                
                Text(currStreak)
                    .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    .foregroundStyle(themeManager.textColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(13)
            }
            .frame(height: 150)
        }
        .padding(.horizontal, 30)
    }
}
