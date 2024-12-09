import Foundation

class RegisterSucceedBuilder {
    static func build() -> RegisterSucceedViewController {
        let viewModel = RegisterSucceedViewModel()
        let viewController = RegisterSucceedViewController(viewModel: viewModel)        
        return viewController
    }
}
