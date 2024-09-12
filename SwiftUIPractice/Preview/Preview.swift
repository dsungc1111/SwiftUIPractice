//
//  Preview.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/12/24.
//

import SwiftUI

struct Preview: View {
    
    @State var currentDate: Date
    @State var selectedDate: Date
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(hex: "#57a3ff"))
                            .frame(width: 350, height: 160)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(hex: "#57a3ff"))
                            .opacity(0.3)
                            .frame(width: 350, height: 200)
                        VStack {
                            CalendarView(currentDate: $currentDate, selectedDate: $selectedDate)
                        }
                    }
                }
            }
        }
        TabBar()
    }
}

struct CalendarView: View {
    
    var weekDays = ["일","월", "화", "수", "목", "금", "토"]
    
    @Binding var currentDate: Date
    @Binding var selectedDate: Date
    
    
    private let calendar = Calendar.current
    
    
    private var month: Int {
        calendar.component(.month, from: currentDate)
    }
    private var year: Int {
        calendar.component(.year, from: currentDate)
    }
    
    private var daysInMoth: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for:  currentDate) else { return [] }
        
        var dates = [Date]()
        
        calendar.enumerateDates(startingAfter: monthInterval.start, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime) { date, exactMatch, stop in
            if let date = date, date <= monthInterval.end {
                dates.append(date)
            } else {
                stop = true
            }
        }
        
        return dates
        
    }
    var body: some View {
        
        
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), content: {
                ForEach(weekDays, id: \.self) { item in
                    Text(item)
                        .foregroundStyle(item == "일" ? .red : .black)
                }
            })
            .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), content: {
                ForEach(0..<6) { row in
                    ForEach(0..<7) { column in
                        
                        if let date = dateFor(row: row, column: column) {
                            
                            let isSundy = calendar.component(.weekday, from: date) == 1
                            
                            VStack {
                                Text("\(calendar.component(.day, from: date - 1))")
                                    .foregroundStyle(isSundy ? .red : .black)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.top)
                            
                            
                        } else {
                            Text("")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            })
        }.padding(.horizontal)
    }
    
    private func dateFor(row: Int, column: Int) -> Date? {
        let firstDayIndex = calendar.component(.weekday, from: daysInMoth.first!) - calendar.firstWeekday
        let index = row * 7 + column - firstDayIndex
        return index >= 0 && index < daysInMoth.count ? daysInMoth[index] : nil
        
        
    }
    
    private func dayInCurrentMont() -> [Date] {
        guard let range = calendar.range(of: .weekday, in: .month, for: selectedDate),
              let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)) else { return [] }
        
        
        return range.compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }
}

#Preview {
    Preview(currentDate: Date(), selectedDate: Date())
}
