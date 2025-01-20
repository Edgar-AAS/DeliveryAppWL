protocol UpdateProfileDataUseCase {
    var httpResource: ((UpdateProfileDataRequest) -> ResourceModel)? { get set }
    func update(with request: UpdateProfileDataRequest, onComplete: @escaping (Result<Void, UpdateProfileDataError>) -> Void)
}
