import Foundation

protocol AlertViewProtocol: AnyObject {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Serializable {
    let title: String
    let message: String
}
