protocol UpdateProfileDataUseCase {
    var httpResource: ((UpdateProfileRequestDTO) -> ResourceModel)? { get set }
    func update(with request: UpdateProfileRequestDTO, onComplete: @escaping (Result<UpdateProfileResponseDTO, UpdateProfileError>) -> Void)
}
