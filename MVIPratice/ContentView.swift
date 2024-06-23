//
//  ContentView.swift
//  MVIPratice
//
//  Created by 김진수 on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    var container = MVIContainer()
    
    var body: some View {
        ZStack {
            VStack {
                
                Button {
                    container.send(.buttonTouch)
                } label: {
                    Text("\(container.state.num)")
                }
                
            }

        }.sheet(isPresented: Binding(get: { container.state.isValid }, set: { value in
            container.send(.viewDismiss(value))
        }), content: {
            SecondView(values: container.state.num, text: container.state.text)
        })
        
    }
    
}

#Preview {
    ContentView()
}

struct SecondView: View {
    
    var values: Int
    var text: String
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(values)")
                    .bold()
                    .font(.title)
                .foregroundStyle(.red)
            }
            
            Text(text)
                .bold()
                .font(.title)
                .foregroundStyle(.black)
        }
    }
    
}
