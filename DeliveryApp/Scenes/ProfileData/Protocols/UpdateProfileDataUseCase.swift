protocol UpdateProfileDataUseCase {
    var httpResource: ((UserRequest) -> ResourceModel)? { get set }
    func update(with request: UserRequest, onComplete: @escaping (Result<Void, UpdateProfileDataError>) -> Void)
}
