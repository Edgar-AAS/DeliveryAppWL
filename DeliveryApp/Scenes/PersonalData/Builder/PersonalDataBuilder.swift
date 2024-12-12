import UIKit

final class PersonalDataBuilder {
    static func build(userId: Int) -> PersonalDataViewController {
        let httpClient = HTTPClient()
        let updateProfile = UpdateProfile(httpClient: httpClient)
        let viewModel = PersonalDataViewModel(updateProfile: updateProfile)
        let viewController = PersonalDataViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        
        updateProfile.httpResource = { profileRequest in
            let body = profileRequest.toData()
            
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/account/\(userId)")!,
                method: .post(body),
                headers: ["Content-Type": "application/json"]
            )
        }
        
        return viewController
    }
}
