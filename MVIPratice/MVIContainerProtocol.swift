//
//  MVIContainerProtocol.swift
//  MVIPratice
//
//  Created by 김진수 on 6/8/24.
//

import Foundation

protocol MVIContainerProtocol {
    associatedtype Intent
//    associatedtype UserState
    
//    var state: UserState { get set }
    
    func send(_ intent: Intent) 
}
