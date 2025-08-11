//
//  Untitled.swift
//  Locked In
//
//  Created by Cole Carter on 8/11/25.
//

import SwiftUI


struct CirclesNavView : View {
    
    @Binding var currTab: Int
    var totalPages: Int
    
    var body: some View {
        HStack(spacing: 40) {
            Button {
                currTab = 0  // +1 because 0 = HomeView
            } label: {
                Circle()
                    .fill(currTab == 0 ? Color.black : Color.gray)
                    .frame(width: 8, height: 8)
                    .padding(16)
                    .padding(.horizontal, 20)
            }
            .contentShape(Rectangle())
            .buttonStyle(.plain)
            
            
            Button {
                currTab = totalPages - 1  // +1 because 0 = HomeView
            } label: {
                Circle()
                    .fill(currTab == totalPages - 1 ? Color.black : Color.gray)
                    .frame(width: 8, height: 8)
                    .padding(16)
                    .padding(.horizontal, 20)
            }
            .contentShape(Rectangle())
            .buttonStyle(.plain)
            
        }
        .padding(.vertical, 0)
    }
}
