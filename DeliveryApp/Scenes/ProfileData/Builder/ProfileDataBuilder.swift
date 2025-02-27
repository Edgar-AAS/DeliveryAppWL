import UIKit

final class ProfileDataBuilder {
    static func build(userId: Int) -> ProfileDataViewController {
        let httpClient = HTTPClient()
        let updateProfile = UpdateProfileData(httpClient: httpClient)
        
        let fetchProfileDataResource = ResourceModel(
            url: URL(string: "http://localhost:5177/v1/account/details/\(userId)")!,
            method: .get([]),
            headers: ["Content-Type": "application/json"])
        
        
        let updateProfileImage = UpdateProfileImage(httpClient: httpClient)
        
        updateProfileImage.httpResource = { profileImage in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/account/user/\(userId)/avatar")!,
                method: .put(profileImage.toData()),
                headers: ["Content-Type": "application/json"])
        }
        
        let fetchProfileData = FetchProfileData(httpClient: httpClient, httpResource: fetchProfileDataResource)
        
        let viewModel = ProfileDataViewModel(
            updateProfile: updateProfile,
            fetchProfileData: fetchProfileData,
            updateProfileImage: updateProfileImage)
        
        let viewController = ProfileDataViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        viewModel.alertView = viewController

        viewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        updateProfile.httpResource = { profileRequest in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/account/\(userId)")!,
                method: .put(profileRequest.toData()),
                headers: ["Content-Type": "application/json"]
            )
        }
        
        return viewController
    }
}
  
