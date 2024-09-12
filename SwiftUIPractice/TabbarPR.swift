//
//  TabbarPR.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/11/24.
//

import SwiftUI


import SwiftUI

struct TabbarPR: View {
    @State private var selectedTab: Int = 1

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Image(systemName: "house")
                            .foregroundColor(selectedTab == 1 ? .white : .gray)
                            .padding(8)
                            .background(selectedTab == 1 ? Color.purple : Color.clear)
                            .clipShape(Circle())
                    }
                }

                Spacer()

                Button(action: {
                    selectedTab = 2
                }) {
                    VStack {
                        Image(systemName: "calendar")
                            .foregroundColor(selectedTab == 2 ? .white : .gray)
                            .padding(8)
                            .background(selectedTab == 2 ? Color.purple : Color.clear)
                            .clipShape(Circle())
                      
                    }
                }

                Spacer()
                Button(action: {
                    selectedTab = 3
                }) {
                    VStack {
                        Image(systemName: "person")
                            .foregroundColor(selectedTab == 3 ? .white : .gray)
                            .padding(8)
                            .background(selectedTab == 3 ? Color.green : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(Color(UIColor.systemGray6)) // Light background
            .frame(width: 300)
            .clipShape(.rect(cornerRadius: 30))
            .shadow(radius: 2)
        }
    }
}



#Preview {
    TabbarPR()
}
