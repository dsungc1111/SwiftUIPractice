//
//  RandomImage.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/4/24.
//

import SwiftUI

struct RandomImage: View {
    
    @State private var number = Int.random(in: 1..<100)
    
    var body: some View {
        
        let url = URL(string: "https://picsum.photos/id/340/400/420")
        
        ZStack {
            mainImageView(url)
            badgeView()
            playButton()
            Text("미리보기")
        }
        Spacer()
    }
    
    func playButton() -> some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "plus")
                Text("내 컨텐츠")
            }
            .foregroundStyle(.white)
            .bold()
            Spacer()
            Button(action: {
                print("재생버튼")
            }, label: {
                HStack {
                    Image(systemName: "play.fill")
                    Text("재생")
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
                .background(.white)
                .foregroundStyle(.black)
                .clipShape(.capsule)
            })
            Spacer()
            VStack {
                Image(systemName: "info.circle")
                Text("정보")
            }
            .foregroundStyle(.white)
            Spacer()
        }
        .offset(y: 180)
    }
    
    func mainImageView(_ url: URL?) -> some View {
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                ProgressView()
                    .frame(width: 200, height: 300)
            case .success(let image):
                image.frame(width: 300, height: 300)
            case .failure(let error):
                ProgressView()
                    .frame(width: 200, height: 300)
            default:
                ProgressView()
                    .frame(width: 200, height: 300)
            }
        }
    }
    
    func badgeView() -> some View {
        HStack {
            Image("single-badge")
                .resizable()
                .frame(width: 30, height: 40)
                .padding()
            Spacer()
            Text("TV 프로그램")
            Spacer()
                
            Text("영화")
            Spacer()
            Text("내가 찜한 컨텐츠")
                
            Spacer()
        }
        .foregroundStyle(.white)
        .bold()
        .frame(width: .infinity)
        .offset(y: -120)
    }
}

#Preview {
    RandomImage()
}
