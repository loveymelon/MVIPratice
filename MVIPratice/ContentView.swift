//
//  ContentView.swift
//  MVIPratice
//
//  Created by 김진수 on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State
    private var num: Int = 0
    
    @State
    private var isValid: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("aa")
                
                Button {
                    isValid.toggle()
                } label: {
                    Text("\(num)")
                }
            }

        }.sheet(isPresented: $isValid) {
            SecondView(values: $num)
        }
        
    }
}

#Preview {
    ContentView()
}

struct SecondView: View {
    
    @Binding
    var values: Int
    
    var body: some View {
        ZStack {
            Text("\(values)")
                .bold()
                .font(.title)
                .foregroundStyle(.red)
        }
    }
    
}
