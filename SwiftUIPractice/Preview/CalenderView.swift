//
//  CalenderView.swift
//  SwiftUIPractice
//
//  Created by 최대성 on 9/12/24.
//

import SwiftUI

struct CalenderView: View {
    
    @State private var currentDate = Date()
    
    var body: some View {
        DatePicker(
               "Start Date",
               selection: $currentDate,
               displayedComponents: [.date]
           )
        .datePickerStyle(.graphical)
    }
}

#Preview {
    CalenderView()
}
