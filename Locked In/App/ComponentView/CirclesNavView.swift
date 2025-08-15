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
    
    @EnvironmentObject var themeManager : ThemeManager
    
    var body: some View {
        HStack(spacing: 40) {
            Button {
                currTab = 0  // +1 because 0 = HomeView
            } label: {
                Circle()
                    .fill(currTab == 0 ? themeManager.circlesSelected : themeManager.circlesNotSel)
                    .frame(width: 8, height: 8)
                    .padding(16)
                    .padding(.horizontal, 20)
            }
            .contentShape(Rectangle())
            .buttonStyle(.plain)
            
            
            Button {
                currTab = 1  // +1 because 0 = HomeView
            } label: {
                Circle()
                    .fill(currTab == 1 ? themeManager.circlesSelected : themeManager.circlesNotSel)
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
