//
//  MVIContainer.swift
//  MVIPratice
//
//  Created by 김진수 on 6/8/24.
//

import Foundation
import Combine

// MVIContainerProtocol의 용도
// 프로젝트 내에서 사용되는 컨테이너, Intent, State, send가 하나씩만 있을 가능성이 없고
// 각자 명시된 이름들은 같지만 알맹이들은 다를 것이다.
// 그래서 명시적으로 나타내는 역할을 해주는 것이다.
// "이건 컨테이너인데 무슨 역할을 하는 컨테이너냐면 Intent, State, send들을 가지고 있어"
// 이렇게 되면 가독성있는 컨테이너가 완성된다.

// ObservableObject의 용도
// 뷰가 State의 변경 사항을 계속 알고 거기에 맞게 랜더링되야되는데
// 이걸 위해선 지속적인 관찰이 필요하다. 그래서 ObservableObject 붙이므로써 뷰가 이걸 특정하나가 아닌 전체를 관찰하도록 하는 것이다.
// 그럼 내가 추구하는 완벽한 MVI패턴 단방향이 완성된다.

// URL(string: "http://numbersapi.com/\(state.count)")!)
// String(decoding: data, as: UTF8.self)

final class MVIContainer: ObservableObject, MVIContainerProtocol {
    
    // 뷰가 dismiss될 시에 swiftUI에서는 Bool값을 설정해준다.
    // state는 private(set)로 되어있기 때문에 외부에서 값 설정이 안된다.
    // 그래서 이때 값을 받고 send에서 받은 값을 변경해준다.
    // 그럼 거의 완벽한 단방향이다.
    // 뷰는 어떤 인텍트가 벌어지고 값을 전달만해주고 값이 바뀌면 뷰가 변경
    // Input
    enum Intent {
        case buttonTouch
        case viewDismiss(Bool)
    }
    
    // state를 외부에서 선언하지 않고 내부에서 선언한 이유
    // 내 의도는 하나의 뷰가 하나의 컨테이너만 가지고 있고 각 뷰에 대한 state만 가지고 있어야 한다.
    // 하지만 외부에 선언을 하게되면 해당 컨테이너만 접근이 가능한 것이 아니라 다른 곳에서도 접근이 가능하기 때문에
    // 내부로 선언하여서 막은 것이다.
    // Output
    struct State {
        var isValid: Bool = false
        var num: Int = 0
        var text: String = ""
    }
    
    // private(set)은 완벽한 단방향을 위해서 선언 / 외부에서는 읽을 수만 있고 내부에서 수정, 읽기 가능
    @Published
    private(set) var state: State = State()
        
    // send의 용도
    // 뷰가 특정 intent로 들어왔을때 intent가 상황에 맞게 각 뷰에 대한 모델/State의 값을 변경시켜준다.
    // 그럼 뷰는 private(set)로 선언된 state의 변경된 값을 바라보고 랜더링 되는 것이다.
    func send(_ intent: Intent) {
        switch intent {
        case .buttonTouch:
            
            state.num += 1
            
            let url = URL(string: "http://numbersapi.com/\(state.num)")!
            
            Task {
                
                let (data, _) = try await URLSession.shared.data(from: url)
                
                print("net", data)
                
                state.text = String(decoding: data, as: UTF8.self)
                
                state.isValid.toggle()
                
            }
            
        case .viewDismiss(let isValid):
            
            state.isValid = isValid
            
        }
    }
    
}
