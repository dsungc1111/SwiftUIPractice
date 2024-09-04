//
//  SearchView.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/3/24.
//

import SwiftUI


struct Company {
    let name: String
    let priority: Int
}

struct SearchView: View {
    
    
    @State private var marketList: Markets = []
    
    @State private var text = ""
//    private var data = [
//        Company(name: "Amazon", priority: 0),
//        Company(name: "Apple", priority: 1),
//        Company(name: "Google", priority: 2),
//        Company(name: "Tesla", priority: 3),
//        Company(name: "X", priority: 4),
//        Company(name: "Facebook", priority: 5)
//    ]
//    @State private var text = ""
    
//    private var filteredList: [Company] {
//        return text.isEmpty ? data : data.filter {
//            $0.name.lowercased().contains(text.lowercased()) }
//    }

    private var newList: Markets {
        return text.isEmpty ? marketList : marketList.filter { $0.koreanName.contains(text)}
    }
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(newList, id: \.self) { item in
                        Text(item.koreanName)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }
                .padding()
                .searchable(text: $text, placement: .navigationBarDrawer, prompt: "검색검색")
            }
            .task {
                do {
                    let result = try await UpbitAPI.fetchMArket()
                    marketList = result
                } catch {
                    
                }
        }
        }
    }
}

#Preview {
    SearchView()
}
