//
//  SearchView.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/3/24.
//

import SwiftUI



struct SearchView: View {
    
    
    @State private var marketList: Markets = []
    
    @State private var text = ""
    
    @State private var myCoin = ""

    @State private var newList: Markets = []
    
    var body: some View {
        TextfieldView()
        NavigationView {
            ScrollView {
                bannerView()
                listView()
            }
            .task {
                do {
                    let result = try await UpbitAPI.fetchMArket()
                    marketList = result
                    newList = result
                    myCoin = result[Int.random(in: 0..<marketList.count)].koreanName
                } catch {
                    
                }
            }
        }
    }
    
    func TextfieldView() -> some View {
        
        TextField("입력하세요", text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .onSubmit {
                newList = text.isEmpty ? newList : newList.filter { $0.koreanName.contains(text) }
            }
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
        VStack {
            ForEach($newList, id: \.id) { item in
                NavigationLink {
                    CoinListview(item: item)
                } label: {
                    CoinListview(item: item)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
        }

    }
}
struct CoinListview: View {
    
    @Binding var item: Market
    
    var body: some View {
        HStack {
            LazyVStack(alignment: .leading) {
                Text(item.koreanName)
                    .font(.title2)
                    .bold()
                Text(item.englishName)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button {
                item.isLike.toggle()
            } label: {
                Image(systemName: item.isLike ? "star.fill" : "star")
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
}


#Preview {
    SearchView()
}
