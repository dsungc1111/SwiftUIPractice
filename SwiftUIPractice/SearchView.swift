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
    
    @State private var myCoin = ""

    @State private var isLike = false
    
    private var newList: Markets {
        return text.isEmpty ? marketList : marketList.filter { $0.koreanName.contains(text)}
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextfieldView()
                bannerView()
                listView()
            }
        }
    }
    
    func TextfieldView() -> some View {
        TextField("입력하세요", text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
                print(text)
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
    
    func bannerView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.brown)
                .frame(width: 340, height: 150)
                .overlay(alignment: .leading) {
                    Circle()
                        .fill(
                            .background
                                .opacity(0.3)
                        )
                        .scaleEffect(1.8)
                }
            VStack {
                Text("보유 코인")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(myCoin)
            }
            .offset(x: -100, y: 40)
            .foregroundStyle(.white)
            .font(.headline)
            .bold()
        }
    }
    
    func listView() -> some View {
        List { // lazy하게 동작하는구나
            ForEach(newList, id: \.self) { item in
                HStack {
                    NavigationLink {
                        NavigationWrapperView(view: Coinview())
                    } label: {
                        HStack {
                            Text(item.koreanName)
                                .font(.title)
                        }
                    }
                    Button(action: {
                        isLike.toggle()
                    }, label: {
                        Image(systemName: isLike ? "star.fill" : "star")
                    })
                }
            }
        }
        .listStyle(.plain)
//        .searchable(text: $text, placement: .navigationBarDrawer, prompt: "검색검색")
        .task {
            do {
                let result = try await UpbitAPI.fetchMArket()
                marketList = result
                myCoin = result[Int.random(in: 0..<marketList.count)].koreanName
            } catch {
                
            }
        }
    }
}


struct Coinview: View {
    var body: some View {
        Text("colacola")
    }
}


#Preview {
    SearchView()
}
