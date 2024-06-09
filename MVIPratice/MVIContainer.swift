//
//  MVIContainer.swift
//  MVIPratice
//
//  Created by 김진수 on 6/8/24.
//

import Foundation
import Combine

final class MVIContainer: ObservableObject, MVIContainerProtocol {
    
    enum Intent {
        case buttonTouch
    }
    
    @Published private(set) var state = NumberState()
    
    func send(_ intent: Intent) {
        switch intent {
        case .buttonTouch:
            state.isValid.toggle()
            state.num += 1
        }
    }
    
}
