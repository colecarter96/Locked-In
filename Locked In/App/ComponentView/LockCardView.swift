//
//  LockCardView.swift
//  Locked In
//
//  Created by Cole Carter on 8/4/25.
//

import SwiftUI

struct LockCardView: View {
    
    var statusText: String
    var titleText: String
    var subtitleText: String
    
    @EnvironmentObject var themeManager : ThemeManager
    
    var body: some View {
        // Lock Box
        ZStack (alignment: .topLeading){
            RoundedRectangle(cornerRadius: 20)
                .fill(themeManager.cardColor)
                .frame(height: 300)
            
            Text(statusText)
                .font(.pretendard(fontStyle: .callout, fontWeight: .regular))
                .foregroundColor(themeManager.habitStatus)
                .padding(15)
            
//            Rectangle()
//                .frame(width: 200, height: 200)
            Image("LockTemp")
                .resizable()
                .frame(width: 133.33, height: 200)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            
            VStack(alignment: .leading, spacing: 0){
                Text(titleText)
                    .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    .foregroundStyle(themeManager.textColor)
                
                Text(subtitleText)
                    .font(.pretendard(fontStyle: .title3, fontWeight: .medium))
                    .foregroundStyle(themeManager.textColor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(15)
        }
        .padding(.horizontal, 30)
        .frame(height: 300)
        
    }
    
}
