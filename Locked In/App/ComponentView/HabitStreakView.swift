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
    
    var body: some View{
        // Habit Type Side by Side
        HStack {
            ZStack (alignment: .topLeading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
                    .frame(height: 150)
                
                Text("Habit Type")
                    .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
                    .padding(13)
                
                Text(habitType)
                    .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(13)
            }
            .frame(height: 150)
            
            ZStack (alignment: .topLeading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
                    .frame(height: 150)
                
                Text("Streak")
                    .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
                    .padding(13)
                
                Text(currStreak)
                    .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(13)
            }
            .frame(height: 150)
        }
        .padding(.horizontal, 30)
    }
}
