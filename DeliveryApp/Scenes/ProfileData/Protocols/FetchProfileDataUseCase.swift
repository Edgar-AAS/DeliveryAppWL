protocol FetchProfileDataUseCase {
    func fetch(onComplete: @escaping (Result<UserRequest, FetchProfileDataError>) -> Void)
}
