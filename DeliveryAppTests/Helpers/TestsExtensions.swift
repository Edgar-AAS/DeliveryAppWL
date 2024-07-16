//
//  TestsExtensions.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 16/07/24.
//

import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
