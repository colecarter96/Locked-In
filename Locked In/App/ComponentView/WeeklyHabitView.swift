//
//  WeeklyHabitView.swift
//  Locked In
//
//  Created by Cole Carter on 8/4/25.
//

import SwiftUI


struct WeeklyHabitView : View {
    var habitName: String
    var habitState: String
    var dayCompletionFlags: [Bool] // 7 elements: Sunday to Saturday

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.99, green: 0.99, blue: 0.99))
                .frame(height: 150)

            Text(habitName)
                .font(.pretendard(fontStyle: .subheadline, fontWeight: .regular))
                .foregroundColor(Color.gray)
                .padding(13)

            Text(habitState)
                .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(13)

            // Bars for each day
            HStack {
                ForEach(0..<7, id: \.self) { index in
                    if dayCompletionFlags[index] {
                        Rectangle()
                            .frame(width: 3, height: 40)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 3, height: 40)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .padding(.trailing, 30)
            .padding(.top, 30)
        }
        .frame(height: 150)
        .padding(.horizontal, 30)
        .padding(.top, 5)
    }
}




//struct WeeklyHabitView : View{
//
//    var habitName: String
//    var habitState: String
//    
//    var body: some View{
//        ZStack (alignment: .topLeading){
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
//                .frame(height: 150)
//            
//            Text(habitName)
//                .font(.pretendard(fontStyle: .subheadline, fontWeight: .regular))
//                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
//                .padding(13)
//            
//            Text(habitState)
//                .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//                .padding(13)
//            
//            HStack {
//                Rectangle()
//                    .frame(width:3, height: 40, alignment: .center)
//                Rectangle()
//                    .frame(width:3, height: 40, alignment: .center)
//                Rectangle()
//                    .frame(width:3, height: 40, alignment: .center)
//                Rectangle()
//                    .frame(width:3, height: 40, alignment: .center)
//                Rectangle()
//                    .stroke(Color.black, lineWidth: 1)
//                    .frame(width:3, height: 40, alignment: .center)
//                Rectangle()
//                    .stroke(Color.black, lineWidth: 1)
//                    .frame(width:3, height: 40, alignment: .center)
//                Rectangle()
//                    .stroke(Color.black, lineWidth: 1)
//                    .frame(width:3, height: 40, alignment: .center)
//                
//            }
//            .frame(maxWidth: .infinity, alignment: .topTrailing)
//            .padding(.trailing, 30)
//            .padding(.top, 30)
//        }
//        .frame(height: 150)
//        .padding(.horizontal, 30)
//        .padding(.top, 5)
//        
//    }
//}
