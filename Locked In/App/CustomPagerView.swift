//
//  CustomPagerView.swift
//  Locked In
//
//  Created by Cole Carter on 8/5/25.
//
//
import SwiftUI



// Old one
struct CustomPagerView<Content: View>: View {
    @Binding var currentIndex: Int  // changed from @State to @Binding
    @GestureState private var dragOffset: CGFloat = 0

    let totalPages: Int
    let content: () -> Content

    init(currentIndex: Binding<Int>, totalPages: Int, @ViewBuilder content: @escaping () -> Content) {
        self._currentIndex = currentIndex
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
            .offset(x: -CGFloat(currentIndex) * geo.size.width)
            .offset(x: dragOffset)
            .animation(.interactiveSpring(), value: currentIndex)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        let translation = value.translation.width
                        if (currentIndex == 0 && translation > 0) || (currentIndex == totalPages - 1 && translation < 0) {
                            state = 0
                        } else {
                            state = translation
                        }
                    }
                    .onEnded { value in
                        let translation = value.translation.width
                        let threshold = geo.size.width / 20

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



// one with dots
//struct CustomPagerView<Content: View>: View {
//    @Binding var currentIndex: Int
//    @GestureState private var dragOffset: CGFloat = 0
//
//    let totalPages: Int
//    let content: () -> Content
//
//    init(currentIndex: Binding<Int>, totalPages: Int, @ViewBuilder content: @escaping () -> Content) {
//        self._currentIndex = currentIndex
//        self.totalPages = totalPages
//        self.content = content
//    }
//
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                // Navigation circles at the top
//                HStack(spacing: 90) {
//                    Circle()
//                        .fill(currentIndex == 0 ? Color.black : Color.gray)
//                        .frame(width: 8, height: 8)
//                        .onTapGesture { currentIndex = 0 }
//
//                    Circle()
//                        .fill(currentIndex == totalPages - 1 ? Color.black : Color.gray)
//                        .frame(width: 8, height: 8)
//                        .onTapGesture { currentIndex = totalPages - 1 }
//                }
//                .padding(.vertical, 16)
//
//                // Pager content below circles
//                HStack(spacing: 0) {
//                    
//                    content()
//                        .frame(width: geo.size.width)
//                }
//                .frame(width: geo.size.width, alignment: .leading)
//                .offset(x: -CGFloat(currentIndex) * geo.size.width)
//                .animation(.interactiveSpring(), value: currentIndex)
//                .offset(x: dragOffset)
//                .gesture(
//                    DragGesture()
//                        .updating($dragOffset) { value, state, _ in
//                            let translation = value.translation.width
//                            if (currentIndex == 0 && translation > 0) || (currentIndex == totalPages - 1 && translation < 0) {
//                                state = 0
//                            } else {
//                                state = translation
//                            }
//                        }
//                        .onEnded { value in
//                            let translation = value.translation.width
//                            let threshold = geo.size.width / 10
//
//                            if translation < -threshold && currentIndex < totalPages - 1 {
//                                currentIndex += 1
//                            } else if translation > threshold && currentIndex > 0 {
//                                currentIndex -= 1
//                            }
//                        }
//                )
//            }
//            .background(Color(red:0.90, green: 0.90, blue: 0.90, opacity: 1.0))
//        }
//    }
//}

//
//struct CustomPagerView<Content: View>: View {
//    @Binding var currentIndex: Int
//    @GestureState private var dragOffset: CGFloat = 0
//
//    let totalPages: Int
//    let content: () -> Content
//
//    init(currentIndex: Binding<Int>, totalPages: Int, @ViewBuilder content: @escaping () -> Content) {
//        self._currentIndex = currentIndex
//        self.totalPages = totalPages
//        self.content = content
//    }
//
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                // Navigation circles at the top
//                
//                VStack{
//                    HStack(spacing: 90) {
//                        Circle()
//                            .fill(currentIndex == 0 ? Color.black : Color.gray)
//                            .frame(width: 8, height: 8)
//                            .onTapGesture { currentIndex = 0 }
//
//                        Circle()
//                            .fill(currentIndex == totalPages - 1 ? Color.black : Color.gray)
//                            .frame(width: 8, height: 8)
//                            .onTapGesture { currentIndex = totalPages - 1 }
//                    }
//                    .padding(.vertical, 16)
//                    
//                    // Pager content below circles
//                    HStack(spacing: 0) {
//                        
//                        content()
//                            .frame(width: geo.size.width)
//                    }
//                    .frame(width: geo.size.width, alignment: .leading)
//                    .offset(x: -CGFloat(currentIndex) * geo.size.width)
//                    .animation(.interactiveSpring(), value: currentIndex)
//                    .offset(x: dragOffset)
//                    .gesture(
//                        DragGesture()
//                            .updating($dragOffset) { value, state, _ in
//                                let translation = value.translation.width
//                                if (currentIndex == 0 && translation > 0) || (currentIndex == totalPages - 1 && translation < 0) {
//                                    state = 0
//                                } else {
//                                    state = translation
//                                }
//                            }
//                            .onEnded { value in
//                                let translation = value.translation.width
//                                let threshold = geo.size.width / 10
//                                
//                                if translation < -threshold && currentIndex < totalPages - 1 {
//                                    currentIndex += 1
//                                } else if translation > threshold && currentIndex > 0 {
//                                    currentIndex -= 1
//                                }
//                            }
//                    )
//                }
//            }
//            .background(Color(red:0.90, green: 0.90, blue: 0.90, opacity: 1.0))
//        }
//    }
//}
