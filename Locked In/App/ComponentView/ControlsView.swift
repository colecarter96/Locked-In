//
//  ControlsView.swift
//  Locked In
//
//  Created by Cole Carter on 8/4/25.
//

import SwiftUI

struct ControlsView: View {
    
    @State private var isRed = false
    
    var daysLocked: String
    var lockGoal: String
    
//    var onEllipsisTapped: () -> Void  // <-- Add this
    
//    var lockedIn: Bool = false
    
    var body: some View {
        // Bottom Section
        VStack (spacing: 0){
            HStack(alignment: .lastTextBaseline){
                Text("Days Locked")
                    .font(.pretendard(fontStyle: .headline, fontWeight: .semibold))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
                Text(daysLocked)
                    .padding(.trailing, 20)
                    .font(.pretendard(size: 44, weight: .regular))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0))
                Text("Lock Goal")
                    .padding(.leading, 20)
                    .font(.pretendard(fontStyle: .headline, fontWeight: .semibold))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4, opacity: 1.0))
                Text(lockGoal)
                    .font(.pretendard(size: 64, weight: .regular))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2, opacity: 1.0))
                
            }
            .padding(.bottom, 0)
            
            Rectangle()
                .fill(Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
                .frame(height: 2)
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            
            HStack {
                
                GeometryReader { geo in
                    ZStack{
                        Circle()
                            .fill(isRed ? .red : Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.0))
                            .frame(width: geo.size.width * 0.85, height: geo.size.width * 0.85) // limit max size if you want
                            .position(x: geo.size.width / 2, y: geo.size.height / 2) // center the circle inside its geometry reader
                            .padding(.bottom, 10)
                            .onTapGesture {
                                isRed.toggle()

                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                
//                                lockedIn.toggle()
                            }
                        
                        Text("Lock")
                            .font(.pretendard(fontStyle: .title3, fontWeight: .semibold))
                            .foregroundColor(Color.white)
                    }
                    
                        
                }
                .frame(minWidth: 0, maxWidth: .infinity) // take up all left space
                
                
                Rectangle()
                    .fill(Color(red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                
                
                GeometryReader { geo in
                        Image(systemName: "ellipsis")
                            .font(.largeTitle)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2) // center the image inside geometry reader
//                            .onTapGesture {
//                                onEllipsisTapped()  // <-- Trigger action
//                            }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity) // take up all right space
            }
            .ignoresSafeArea()
            
        }
    }
}
