import UIKit
import PhotosUI

class UpdateProfileDataViewController: UIViewController {
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
    
    private var imageBase64: String?
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
    
    private func showImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
}

extension UpdateProfileDataViewController: UpdateProfileDataViewModelDelegate {
    func updateUI(with response: ProfileDataRequest) {
        customView.updateUI(with: response)
    }
}

extension UpdateProfileDataViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        showAlertView(title: viewModel.title, description: viewModel.message)
    }
}

extension UpdateProfileDataViewController: PersonalDataScreenDelegate {
    func saveButtonDidTapped(_ view: UpdateProfileDataScreen) {
        if let updateProfileRequest = view.getRequestData(image: imageBase64) {
            viewModel.updateProfileData(request: updateProfileRequest)
        }
    }
    
    func personalImageDidTapped(_ view: UpdateProfileDataScreen) {
        showImagePicker()
    }
}

extension UpdateProfileDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(textField) {
            print("SaveChanges")
        }
        return true
    }
}

extension UpdateProfileDataViewController: CodeView {
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

extension UpdateProfileDataViewController: PHPickerViewControllerDelegate {
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
                                self?.imageBase64 = imageBase64
                                self?.customView.profileImage = resizedImage
                            }
                        }
                    }
                }
            }
        }
    }
}
