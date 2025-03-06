import UIKit
import PhotosUI

final class ProfileDataViewController: UIViewController {
    private lazy var customView: UpdateProfileDataScreen = {
        guard let view = view as? UpdateProfileDataScreen else {
            fatalError("View is not of type PersonalDataScreen")
        }
        return view
    }()
    
    private lazy var loadingView: DALoadingView = {
        let loadingView = DALoadingView(frame: .zero)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private var viewModel: UpdateProfileDataViewModelProtocol
    
    init(viewModel: UpdateProfileDataViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        view = UpdateProfileDataScreen(textFieldDelegate: self, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.loadProfileData()
    
        viewModel.loadingHandler = { [weak self] state in
            DispatchQueue.main.async {
                self?.loadingView.handleLoading(with: state)
            }
        }
    }
    
    private func updateUserAvatar(avatar: String) {
        let profileImage = ProfileImage(imageBase64: avatar)
        viewModel.saveImage(profileImage: profileImage)
    }
    
    private func showImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
}

extension ProfileDataViewController: UpdateProfileDataViewModelDelegate {
    func frofileDataViewModel(_ viewModel: ProfileDataViewModel, didUpdateUI response: UserProfileResponse) {
        customView.updateUI(with: response)
    }
    
    func frofileDataViewModel(_ viewModel: ProfileDataViewModel, didUpdateProfileImage image: ProfileImage) {
        customView.profileImage = UIImage.fromBase64(image.imageBase64)
    }
}

extension ProfileDataViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        showAlertView(title: viewModel.title, description: viewModel.message)
    }
}

extension ProfileDataViewController: PersonalDataScreenDelegate {
    func saveButtonDidTapped(_ view: UpdateProfileDataScreen) {
        if let updateProfileRequest = view.getRequestData() {
            viewModel.updateProfileData(request: updateProfileRequest)
        }
    }
    
    func personalImageDidTapped(_ view: UpdateProfileDataScreen) {
        showImagePicker()
    }
}

extension ProfileDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(textField) {
            print("SaveChanges")
        }
        return true
    }
}

extension ProfileDataViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(loadingView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProfileDataViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemprovider = results.first?.itemProvider {
            if itemprovider.canLoadObject(ofClass: UIImage.self) {
                itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async { [weak self] in
                            let targetSize = CGSize(width: 100, height: 100)
                            let resizedImage = selectedImage.resizeImage(image: selectedImage, targetSize: targetSize)
                            
                            if let imageBase64 = resizedImage.toBase64() {
                                self?.updateUserAvatar(avatar: imageBase64)
                            }
                        }
                    }
                }
            }
        }
    }
}
