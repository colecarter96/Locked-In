//
//  AddView.swift
//  Locked In
//
//  Created by Cole Carter on 8/5/25.
//

import SwiftUI

struct AddView: View {
    
    var onAddHabit: (Habit) -> Void
    
    @State private var showingForm = false
    
    
    
    var body: some View {
        VStack (){
                
            // Top Circles
            HStack (spacing: 90) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 8, height: 8)
                Circle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
                
            }
            .padding(.vertical, 16)
            
            ZStack (alignment: .topLeading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
                
                Text("LockedIn")
                    .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
                    .padding(15)
                
                Circle()
                    .fill(Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0))
                    .frame(width: 150, height: 150)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                Button(action: {
                    showingForm = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .sheet(isPresented: $showingForm) {
                    AddHabitFormView { newHabit in
                        onAddHabit(newHabit)
                        showingForm = false
                    }
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Add")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    
                    Text("Lock In New Habit")
                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(15)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
            
            Spacer()
            
        }
        .background(Color(red: 0.92, green: 0.92, blue:0.92, opacity: 1.0))
        .frame(maxWidth: .infinity, alignment: .top)
    }
}


//struct AddView_Preview: PreviewProvider {
//    static var previews: some View{
////        AddView()
//    }
//}

//
//
//import SwiftUI
//
//struct AddView: View {
//    
//    
//    var body: some View {
//        VStack (){
//                
//            // Top Circles
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
//            
//            ZStack (alignment: .topLeading){
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
//                
//                Text("LockedIn")
//                    .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
//                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
//                    .padding(15)
//                
//                Circle()
//                    .fill(Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0))
//                    .frame(width: 150, height: 150)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                
//                Button(action: {
//                    // Your action here
//                }) {
//                    Image(systemName: "plus")
//                        .font(.system(size: 70, weight: .bold))
//                        .foregroundColor(Color(red: 0.99, green: 0.99, blue: 0.99, opacity: 1.0))
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                
//                VStack(alignment: .leading, spacing: 0){
//                    Text("Add")
//                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
//                    
//                    Text("Lock In New Habit")
//                        .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//                .padding(15)
//            }
//            .padding(.horizontal, 30)
//            .padding(.bottom, 40)
//            
//            Spacer()
//            
//        }
//        .background(Color(red: 0.92, green: 0.92, blue:0.92, opacity: 1.0))
//        .frame(maxWidth: .infinity, alignment: .top)
//    }
//}
//
//
//struct AddView_Preview: PreviewProvider {
//    static var previews: some View{
//        AddView()
//    }
//}
