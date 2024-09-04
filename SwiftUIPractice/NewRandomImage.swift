//
//  NewRandomImage.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/4/24.
//

import SwiftUI

struct NewRandomImage: View {
    
    
    let title = [
        "첫번째",
        "두번째",
        "세번째",
        "네번째"
    ]
   
    
    var body: some View {
        
        
        ScrollView(.vertical) {
            ForEach(title, id: \.self) { item in
                Text(item)
                    .font(.headline)
                    .padding(.leading)
                ScrollView(.horizontal) {
                    VStack {
                        HStack {
                            ForEach(0..<10) {_ in
                                var number = Int.random(in: 0...100)
                                let url = URL(string: "https://picsum.photos/id/\(number)/150/200")
                                
                                AsyncImage(url: url)
                                    .clipShape(.buttonBorder)
                            }
                        }
                    }
                }
                
                .scrollIndicators(.hidden)
            }
           
          
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NewRandomImage()
}
