//
//  CoordinatorSpy.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 16/07/24.
//

import Foundation
@testable import DeliveryApp

class CoordinatorSpy: Coordinator {
    private(set) var eventType: DeliveryApp.Event?
    private var emit: ((DeliveryApp.Event) -> Void)?
    
    var navigationController: DeliveryApp.CustomNavigationController?
    
    func start() {}
    
    func observe(completion: @escaping ((DeliveryApp.Event) -> Void)) {
        emit = completion
    }
    
    func eventOcurred(type: DeliveryApp.Event) {
        emit?(type)
    }
}
