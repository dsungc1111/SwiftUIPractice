//
//  LaunchView.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/2/24.
//

import SwiftUI

// 첫번째 뷰(런치뷰)
struct LaunchView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                launchText()
                launchImage()
                    .padding()
                startButton()
                
            }
        }
    }
    
    func launchText() -> some View {
        Image("launch")
    }
    func launchImage() -> some View {
        Image("launchImage")
    }
    func startButton() -> some View {
        NavigationLink("시작하기") {
            ProfileView()
        }
        .font(.title2)
        .frame(width: 350, height: 40)
        .foregroundStyle(.white)
        .background(.blue)
        .clipShape(.capsule)
        .offset(y: 90)
    }
}


#Preview {
    LaunchView()
}
