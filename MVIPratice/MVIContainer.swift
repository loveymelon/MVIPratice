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
        case viewDismiss(Bool)
    }
    
    struct State {
        var isValid: Bool = false
        var num: Int = 0
    }
    
    //state는 내부에
    @Published
    private(set) var state: State = State()
    
    // di init
//    init(state: MVIContainer.State = State()) {
//        self.state = state
//    }
    
    func send(_ intent: Intent) {
        switch intent {
        case .buttonTouch:
            state.isValid.toggle()
            state.num += 1
        case .viewDismiss(let isValid):
            state.isValid = isValid
            state.num -= 1
        }
    }
    
}
