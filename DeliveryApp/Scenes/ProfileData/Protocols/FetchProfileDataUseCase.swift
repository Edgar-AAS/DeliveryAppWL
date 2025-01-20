//
//  FetchProfileDataUseCase.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 20/01/25.
//


protocol FetchProfileDataUseCase {
    func fetch(onComplete: @escaping (Result<ProfileDataRequest, FetchProfileDataError>) -> Void)
}