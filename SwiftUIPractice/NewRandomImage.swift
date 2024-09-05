//
//  NewRandomImage.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/4/24.
//

import SwiftUI

struct SectionModel: Hashable, Identifiable {
    var title: String
    let id = UUID()
}

struct NewRandomImage: View {

    
    @State private var sectionTitle = [
        SectionModel(title: "첫번째"),
        SectionModel(title: "두번째"),
        SectionModel(title: "세번째"),
        SectionModel(title: "네번째")
    
    ]
    
    private var navigtaionTitle = "MY Random Image"
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach($sectionTitle, id: \.id) { item in
                    sectionTitleView(item.title)
                    imageView(item.title)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    func sectionTitleView(_ item: Binding<String>) -> some View {
        
        Text(item.wrappedValue)
            .font(.title2).bold()
            .padding(.leading)
            .navigationTitle(navigtaionTitle)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    
    func imageView(_ text: Binding<String>) -> some View {
        
        ScrollView(.horizontal) {
            VStack {
                HStack {
                    ForEach(0..<10) {_ in
                        let number = Int.random(in: 0...100)
                        let url = URL(string: "https://picsum.photos/id/\(number)/130/180")
                        
                        NavigationLink {
                            SecondView(url: url, text: text)
                        } label: {
                            AsyncImage(url: url)
                                .clipShape(.buttonBorder)
                        }
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
}





struct SecondView: View {
    
    let url: URL?
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            AsyncImage(url: url)
                .clipShape(.buttonBorder)
                .frame(width: 200, height: 300)
            TextField("검색하슈", text: $text)
                .padding()
        }
    }
}

#Preview {
    NewRandomImage()
}
