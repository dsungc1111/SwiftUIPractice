//
//  ProfileView.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/2/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var nickname = ""
    
    //    @State var selectedMbti = false
    
    @State var mbtiList: [String] = []
    
    var body: some View {
        
        VStack {
            imageSettingViewLink()
            nicknameTextField()
            Divider()
                .frame(width: 380)
                .background(.black)
                .padding()
            mbtiText()
            MbtiButton(mbtiList: $mbtiList)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                .offset(y: -75)
            Spacer()
            
            NavigationLink("완료") {
                CompleteView()
            }
            .font(.title2)
            .frame(width: 350, height: 40)
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
            .offset(y: -20)
            
        }
        
    }
    
    
    func mbtiText() -> some View {
        Text("MBTI")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    
    func nicknameTextField() -> some View {
        TextField("닉네임을 입력하세요 :)", text: $nickname)
            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
    }
    
    //MARK: - 이미지세팅 버튼
    func imageSettingViewLink() -> some View {
        NavigationLink { ImageSettingView()
        } label: {
            Image("profile_0")
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(.circle)
                .cornerRadius(55)
                .overlay(
                    RoundedRectangle(cornerRadius: 55)
                        .stroke(.blue, lineWidth: 5)
                )
                .offset(x: 22, y: 20)
            Image(systemName: "camera.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .offset(x: -30, y: 30)
            
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}


struct MbtiButton: View {
    
    
    private let list1 = [ "E", "S", "F", "P"]
    private let list2 = [ "I", "N", "T", "J"]
    
    @State var selectedMbti1: [Bool] = [false, false, false, false]
    @State var selectedMbti2: [Bool] = [false, false, false, false]
    
    @Binding var mbtiList: [String]
    
    var body: some View {
        
        
        VStack {
            HStack {
                
                ForEach(0..<4) { item in
                    
                    Button("\(list1[item])") {
                        selectedMbti1[item].toggle()
                        if selectedMbti1[item] {
                            mbtiList.append(list1[item])
                            selectedMbti2[item] = false
                            for i in 0..<mbtiList.count {
                                if mbtiList[i] == list2[item] {
                                    mbtiList.remove(at: i)
                                    break
                                }
                            }
                        } else {
                            for i in 0..<mbtiList.count {
                                if mbtiList[i] == list1[item] {
                                    mbtiList.remove(at: i)
                                    break
                                }
                            }
                        }
                        print("mbtilist = ", mbtiList)
                    }
                    .frame(width: 60, height: 60)
                    .background( selectedMbti1[item] ? .blue : .white)
                    .foregroundStyle(selectedMbti1[item] ? .white : .blue)
                    .clipShape(.circle)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.blue, lineWidth: 2))
                    
                    
                }
            }
            .padding()
            HStack {
                ForEach(0..<4) { item in
                    Button("\(list2[item])") {
                        selectedMbti2[item].toggle()
                        if selectedMbti2[item] {
                            mbtiList.append(list2[item])
                            selectedMbti1[item] = false
                            for i in 0..<mbtiList.count {
                                if mbtiList[i] == list1[item] {
                                    mbtiList.remove(at: i)
                                    break
                                }
                            }
                        } else {
                            for i in 0..<mbtiList.count {
                                if mbtiList[i] == list2[item] {
                                    mbtiList.remove(at: i)
                                    break
                                }
                            }
                        }
                        print("mbtilist = ", mbtiList)
                    }
                    .frame(width: 60, height: 60)
                    .background( selectedMbti2[item] ? .blue : .white)
                    .foregroundStyle(selectedMbti2[item] ? .white : .blue)
                    .clipShape(.circle)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.blue, lineWidth: 2))
                }
            }
            
        }
    }
}
