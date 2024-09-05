//
//  CategoryView.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/5/24.
//

import SwiftUI


struct Movie: Hashable, Identifiable {
    let id = UUID()
    let movie: String
    let number: Int
}

struct CategoryView: View {
    
    
    @State private var movieList = [
        Movie(movie: "범죄도시", number: 0),
        Movie(movie: "어벤져스", number: 1),
        Movie(movie: "겨울왕국1", number: 2),
        Movie(movie: "겨울왕국2", number: 3)
    ]
    
    private let randomMovie = [
        "111111",
        "2222222",
        "3333333",
        "4444444",
        "5555555",
        "6666666"
    
    ]
    
    var body: some View {
        NavigationView {
            movieListView()
        }
    }
    
    func movieListView() -> some View {
        List(movieList, id: \.id) { item in
            HStack {
                NavigationLink {
                    DetailView()
                } label: {
                    HStack {
                        Text(item.movie)
                        Spacer()
                        Text("\(item.number)")
                    }
                }
            }
        }
        .navigationTitle("영화 추가 뷰")
        .toolbar {
            Button(action: {
                addMovieList()
            }, label: {
                Image(systemName: "plus.circle")
            })
        }
        .scrollIndicators(.hidden)
    }
    
    func addMovieList() {
        movieList.append(Movie(movie: randomMovie.randomElement()!, number: Int.random(in: 0..<20)))
    }
}

struct DetailView: View {
    var body: some View {
        Text("detialviewdfsdfd")
    }
}


#Preview {
    CategoryView()
}
