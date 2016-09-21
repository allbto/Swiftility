//
//  fatalError.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/21/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

// overrides Swift global `fatalError`
func sw_fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never
{
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
    sw_unreachable()
}

/// This is a `noreturn` function that pauses forever
func sw_unreachable() -> Never
{
    repeat {
        RunLoop.current.run()
    } while (true)
}

/// Utility functions that can replace and restore the `fatalError` global function.
struct FatalErrorUtil
{
    // Define alias for fatalError definition
    typealias FatalErrorClosure = (String, StaticString, UInt) -> Void
    
    // Called by the custom implementation of `fatalError`.
    static var fatalErrorClosure: FatalErrorClosure = defaultFatalErrorClosure
    
    // backup of the original Swift `fatalError`
    private static let defaultFatalErrorClosure: FatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    /// Replace the `fatalError` global function with something else.
    static func replaceFatalError(closure: @escaping FatalErrorClosure) {
        fatalErrorClosure = closure
    }
    
    /// Restore the `fatalError` global function back to the original Swift implementation
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
