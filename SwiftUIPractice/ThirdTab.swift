//
//  ThirdTab.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/11/24.
//

import SwiftUI


struct ThirdTab: View {
    @State private var selectedTab: Int = 1

    var body: some View {
        VStack {
            Spacer()
//#c6dae8
            HStack {
                // Main Button
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(selectedTab == 1 ? .white : Color.gray.opacity(0.5))
                        Text("Main")
                            .foregroundColor(selectedTab == 1 ? .white : Color.gray)
                            .font(.caption)
                    }
                }

                Spacer()

                // Search Button
                Button(action: {
                    selectedTab = 2
                }) {
                    VStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(selectedTab == 2 ? .white : Color.gray.opacity(0.5))
                        Text("Search")
                            .foregroundColor(selectedTab == 2 ? .white : Color.gray)
                            .font(.caption)
                    }
                }

                Spacer()

                // Community Button
                Button(action: {
                    selectedTab = 3
                }) {
                    VStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(selectedTab == 3 ? .white : Color.gray.opacity(0.5))
                        Text("Community")
                            .foregroundColor(selectedTab == 3 ? .white : Color.gray)
                            .font(.caption)
                    }
                }

                Spacer()

                // Profile Button
                Button(action: {
                    selectedTab = 4
                }) {
                    VStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(selectedTab == 4 ? .white : Color.gray.opacity(0.5))
                        Text("Profile")
                            .foregroundColor(selectedTab == 4 ? .blue : Color.gray)
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(Color(hex: "#c6dae8"))  // Black background
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
            .padding(.bottom, 30)
        }
    }
}


#Preview {
    ThirdTab()
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
