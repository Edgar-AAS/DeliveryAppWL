import Foundation

public protocol AlertViewProtocol: AnyObject {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel: Serializable {
    public let title: String
    public let message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
