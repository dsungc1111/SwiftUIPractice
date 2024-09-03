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
    
    private var data = [
    
        Company(name: "Amazon", priority: 0),
        Company(name: "Apple", priority: 1),
        Company(name: "Google", priority: 2),
        Company(name: "Tesla", priority: 3),
        Company(name: "X", priority: 4),
        Company(name: "Facebook", priority: 5)
    ]
    
    @State private var text = ""
    
    private var filteredList: [Company] {
        return text.isEmpty ? data : data.filter {
            $0.name.lowercased().contains(text.lowercased()) }
    }
    
    var body: some View {
        //        TextField("회사명", text: $text)
        //            .foregroundStyle(.black)
        //            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        //            .padding()
        
        NavigationView {
            List {
                ForEach(filteredList, id: \.self.priority) { item in
                    Text("\(item.name)")
                        .font(.largeTitle)
                }
            }
            .searchable(text: $text, placement: .navigationBarDrawer, prompt: "회사 검색 ㄱ")
        }
    }
}

#Preview {
    SearchView()
}
