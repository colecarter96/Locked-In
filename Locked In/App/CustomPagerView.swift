//
//  CustomPagerView.swift
//  Locked In
//
//  Created by Cole Carter on 8/5/25.
//
//
import SwiftUI

struct CustomPagerView<Content: View>: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    let totalPages: Int
    let content: () -> Content
    
    init(totalPages: Int, @ViewBuilder content: @escaping () -> Content) {
        self.totalPages = totalPages
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                content()
                    .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, alignment: .leading)
            .offset(x: -CGFloat(currentIndex) * geo.size.width)         // position to current page
            .offset(x: dragOffset)                                       // add drag offset
            .animation(.interactiveSpring(), value: currentIndex)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        // Only allow dragging left/right when within bounds
                        let translation = value.translation.width
                        if (currentIndex == 0 && translation > 0) || (currentIndex == totalPages - 1 && translation < 0) {
                            // Prevent drag beyond first/last page
                            state = 0
                        } else {
                            state = translation
                        }
                    }
                    .onEnded { value in
                        let translation = value.translation.width
                        let threshold = geo.size.width / 4
                        
                        if translation < -threshold && currentIndex < totalPages - 1 {
                            currentIndex += 1
                        } else if translation > threshold && currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
            )
        }
    }
}
//
//import SwiftUI
//
//struct CustomPagerView<Content: View>: View {
//    @State private var currentIndex: Int = 0
//    @GestureState private var dragOffset: CGFloat = 0
//    
//    @Binding var totalPages: Int // <-- make this a binding
//    
//    let content: () -> Content
//    
//    init(totalPages: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
//        self._totalPages = totalPages
//        self.content = content
//    }
//    
//    var body: some View {
//        GeometryReader { geo in
//            HStack(spacing: 0) {
//                content()
//                    .frame(width: geo.size.width)
//            }
//            .frame(width: geo.size.width, alignment: .leading)
//            .offset(x: -CGFloat(currentIndex) * geo.size.width)
//            .offset(x: dragOffset)
//            .animation(.interactiveSpring(), value: currentIndex)
//            .gesture(
//                DragGesture()
//                    .updating($dragOffset) { value, state, _ in
//                        let translation = value.translation.width
//                        if (currentIndex == 0 && translation > 0) || (currentIndex == totalPages - 1 && translation < 0) {
//                            state = 0
//                        } else {
//                            state = translation
//                        }
//                    }
//                    .onEnded { value in
//                        let translation = value.translation.width
//                        let threshold = geo.size.width / 4
//                        
//                        if translation < -threshold && currentIndex < totalPages - 1 {
//                            currentIndex += 1
//                        } else if translation > threshold && currentIndex > 0 {
//                            currentIndex -= 1
//                        }
//                    }
//            )
//        }
//    }
//}
