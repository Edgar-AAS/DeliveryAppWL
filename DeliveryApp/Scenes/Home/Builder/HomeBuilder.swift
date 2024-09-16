import Foundation

class HomeBuilder {
    static func build() -> HomeViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        let viewModel = HomeViewModel(httpClient: httpClient)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}
