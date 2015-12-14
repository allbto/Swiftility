//
//  Dynamic.swift
//  RxTest
//
//  Created by Allan Barbato on 9/9/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = T -> Void
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        self.fire()
    }
    
    func fire() {
        dispatch_async(dispatch_get_main_queue(), {
            self.listener?(self.value)
        })
    }
    
    var value: T {
        didSet {
            self.fire()
        }
    }
    
    var isBinded: Bool {
        return self.listener != nil
    }
    
    init(_ v: T) {
        value = v
    }
}