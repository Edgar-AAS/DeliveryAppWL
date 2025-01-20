import UIKit

final class ProfileDataBuilder {
    static func build(userId: Int) -> UpdateProfileDataViewController {
        let httpClient = HTTPClient()
        let logger = ConsoleLogger()
        let updateProfile = UpdateProfileData(httpClient: httpClient, logger: logger)
        
        let fetchProfileDataResource = ResourceModel(
            url: URL(string: "http://localhost:5177/v1/account/details/\(userId)")!,
            method: .get([]),
            headers: ["Content-Type": "application/json"]
        )
        
        let fetchProfileData = FetchProfileData(httpClient: httpClient, httpResource: fetchProfileDataResource, logger: logger)
        let viewModel = ProfileDataViewModel(updateProfile: updateProfile, fetchProfileData: fetchProfileData)
        let viewController = UpdateProfileDataViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        viewModel.alertView = viewController

        viewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        updateProfile.httpResource = { profileRequest in
            let body = profileRequest.toData()
            
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/account/\(userId)")!,
                method: .put(body),
                headers: ["Content-Type": "application/json"]
            )
        }
        
        return viewController
    }
}
  
