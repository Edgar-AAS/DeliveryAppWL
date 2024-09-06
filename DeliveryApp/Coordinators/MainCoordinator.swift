import UIKit

protocol Coordinator: AnyObject {
    var navigationController: CustomNavigationController? { get set }
    func start()
    func eventOcurred(type: Event)
}

enum Event: Equatable {
    case loginToRegister
    case registerToLogin
    case goToHome
    case goToForgotPassword
    case goToResetPassword
    case goToEmailVerification(User)
    case goToFoodDetails(Food)
    case backToHome
    case goToRegistrationSuccess(RegistrationSuccessModel)
    case backToLogin
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        switch (lhs, rhs) {
        case (.loginToRegister, .loginToRegister):
            return true
        case (.registerToLogin, .registerToLogin):
            return true
        case (.goToHome, .goToHome):
            return true
        case (.goToForgotPassword, .goToForgotPassword):
            return true
        case (.backToHome, .backToHome):
            return true
        case (.goToFoodDetails(let lhsFood), .goToFoodDetails(let rhsFood)):
            return lhsFood == rhsFood
        case (.goToEmailVerification(let lhsUser), .goToEmailVerification(let rhsUser)):
            return lhsUser == rhsUser
        case (.goToRegistrationSuccess(let lhsSuccessModel), .goToRegistrationSuccess(let rhsSuccessModel)):
            return lhsSuccessModel == rhsSuccessModel
        default:
            return false
        }
    }
}

class MainCoordinator: Coordinator {
    var navigationController: CustomNavigationController?
    
    func start() {
        let viewController = LoginBuilder.build(coordinator: self)
        navigationController?.setRootViewController(viewController)
    }
    
    func eventOcurred(type: Event) {
        switch type {
        case .loginToRegister:
            let viewController = RegisterBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController)
        case .registerToLogin:
            navigationController?.popViewController()
        case .goToHome:
            let viewController = HomeBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController)
        case .goToForgotPassword:
            let viewController = ForgotPasswordBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController)
        case .goToEmailVerification(let user):
            let viewController = EmailVerificationBuilder.build(coordinator: self, user: user)
            navigationController?.pushViewController(viewController)
        case .goToFoodDetails(let foodData):
            let viewController = FoodDetailsBuilder.build(coordinator: self, foodModel: foodData)
            navigationController?.pushViewController(viewController)
        case .backToHome:
            navigationController?.popViewController()
        case .goToResetPassword:
            let viewController = ResetPasswordBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController)
        case .goToRegistrationSuccess(let successModel):
            let viewController = RegistrationSuccessBuilder.build(model: successModel, coordinator: self)
            navigationController?.pushViewController(viewController)
        case .backToLogin:
            guard let viewController = navigationController?.viewControllers
                .first(where: { $0 is LoginViewController })
            else { return }
            navigationController?.pop(to: viewController)
        }
    }
}
