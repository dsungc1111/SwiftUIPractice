//
//  NavigationWrapper.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/5/24.
//

import SwiftUI

struct NavigationWrapperView<Content: View>: View {
    
    let view: () -> Content
    
    var body: some View {
        view()
    }
    init(view: @autoclosure @escaping () -> Content) {
        self.view = view
        print("중간 단계 매개체")
    }
}

