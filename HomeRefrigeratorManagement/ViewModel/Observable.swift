//
//  Observable.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        closure(value)
        listener = closure
    }
}

