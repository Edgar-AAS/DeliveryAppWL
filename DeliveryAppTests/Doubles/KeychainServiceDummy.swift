//
//  KeychainServiceDummy.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 06/03/25.
//

import Foundation
@testable import DeliveryApp

final class KeychainServiceDummy: KeychainService {
    func save(key: String, value: String) {}
    func retrieve(key: String) -> String? { return nil }
    func delete(key: String) {}
}
