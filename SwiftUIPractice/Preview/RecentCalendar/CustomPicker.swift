//
//  CustomPicker.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/12/24.
//

import SwiftUI

struct BoxView: View {
    @State var date = Date()
    var body: some View {
        CustomPicker(currentDate: $date)
    }
}

struct CustomPicker: View {
    @Binding var currentDate: Date
    
     var todayDate = Date()
    let weekDays = ["일","월", "화", "수", "목", "금", "토"]
    
    
    // 달 바꿔주는 프로퍼티
    @State private var currentMonth: Int = 0
    
    var body: some View {
        
        VStack(spacing: 35) {
            
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(getDateData()[0])
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                    Text(getDateData()[1])
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                }
                Spacer()
                Button(action: {
//                    withAnimation {
                        currentMonth -= 1
//                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                })
                Button(action: {
                    currentMonth += 1
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                })
            }
            .padding()
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(day == "일" ? .red : .black)
                }
            }
            let colums = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: colums) {
                
                ForEach(getDate()) { item in
                    
                    daysView(value: item)
                        .foregroundStyle(isSameDay(date1: item.date, date2: currentDate) ? .pink : .blue)
                        .onTapGesture {
                            currentDate = item.date
                        }
                }
            }
            .onChange(of: currentMonth) {  newValue in
                currentDate = getCurrentMont()
            }
                               
        }
    }
    @ViewBuilder
    func daysView(value: DateValue) -> some View {
        VStack {
            // 여기에 이벤트 있는지 없는지 동그라미 생성 가능하고
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // Month 가져오기
    func getCurrentMont() -> Date {
        guard let currentMonth = Calendar.current.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        
        return currentMonth
    }
    
    func getDateData() -> [String] {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        
        return date.components(separatedBy: " ")
    }
    
    
    func getDate() -> [DateValue] {
        // Month date 받아오는 로직
        guard let currentMonth = Calendar.current.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return [] }
        
        var days = currentMonth.getDates().compactMap { date -> DateValue in
            // 일자 받아오는 로직
            
            let day = Calendar.current.component(.day, from: date )
            //                print(day)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = Calendar.current.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
        
    }
}

//
extension Date {
    
    func getDates() -> [Date] {
        
        let calendar = Calendar.current
        // 스타트하는 날짜
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
        
    }
}

#Preview(body: {
    BoxView()
})
