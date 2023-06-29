//
//  SnapCarousel.swift
//  fb4app
//
//  Created by Maurice Hennig on 22.03.23.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Hashable>: View {
    var content: (T) -> Content
    var list: [T]
    var onPageChanged: (() -> Void)?
    @State var innerWidth: CGFloat = 0
    
    @GestureState var dragOffsetDuringDrag: CGFloat = 0
    @State var dragOffsetAfterDragEnd: CGFloat = 0
    
    @Binding var index: Int
    
    init(index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T) -> Content, onPageChanged: @escaping (() -> Void) = {}) {
        self._index = index
        self.list = items
        self.content = content
        self.onPageChanged = onPageChanged
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 20.0) {
                ForEach (list, id: \.self) { item in
                    content(item)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .background()
                }
            }
            .offset(x: (CGFloat(index) * (-proxy.size.width - 20)) + dragOffsetAfterDragEnd + dragOffsetDuringDrag)
            .gesture(
                DragGesture()
                    .updating($dragOffsetDuringDrag) { value, out, _ in
                        out = value.translation.width
                    }
                    .onEnded { value in
                        let dragWidth = value.translation.width
                        var progress = -dragWidth / proxy.size.width

                        if (progress < 0) {
                            progress = progress - 0.2
                        } else {
                            progress = progress + 0.2
                        }
                        
                        dragOffsetAfterDragEnd = dragWidth
                        
                        withAnimation(.spring()) {
                            index = max(0, min(index + Int(progress.rounded()), list.count - 1))
                            dragOffsetAfterDragEnd = 0
                            onPageChanged?()
                        }
                    }
            )
        }
    }
}

extension SnapCarousel {
    func onPageChanged(action: @escaping (() -> Void)) -> SnapCarousel {
        SnapCarousel(index: $index, items: list, content: content, onPageChanged: action)
    }
}
