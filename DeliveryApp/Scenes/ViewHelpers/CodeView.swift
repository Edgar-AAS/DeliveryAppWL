//
//  CodeView.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAddiotionalConfiguration()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAddiotionalConfiguration()
    }
    
    func setupAddiotionalConfiguration() {}
}
