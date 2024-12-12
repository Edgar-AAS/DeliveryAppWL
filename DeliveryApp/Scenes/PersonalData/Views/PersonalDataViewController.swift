import UIKit
import PhotosUI

class PersonalDataViewController: UIViewController {
    private lazy var customView: PersonalDataScreen = {
        guard let view = view as? PersonalDataScreen else {
            fatalError("View is not of type PersonalDataScreen")
        }
        return view
    }()
    
    private var viewModel: PersonalDataViewModelProtocol
    
    init(viewModel: PersonalDataViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = PersonalDataScreen(textFieldDelegate: self, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
    
    private func convertImageToBase64(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
        return imageData.base64EncodedString()
    }
    
    private func convertBase64ToImage(base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
}


extension PersonalDataViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        showAlertView(title: viewModel.title, description: viewModel.message)
    }
}

extension PersonalDataViewController: PersonalDataScreenDelegate {
    func personalImageDidTapped(_ view: PersonalDataScreen) {
        configureImagePicker()
    }
}

extension PersonalDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(textField) {
            print("SaveChanges")
        }
        return true
    }
}

extension PersonalDataViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemprovider = results.first?.itemProvider{
            if itemprovider.canLoadObject(ofClass: UIImage.self) {
                itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async { [weak self] in
                            let targetSize = CGSize(width: 100, height: 100)
                            let resizedImage = selectedImage.resizeImage(image: selectedImage, targetSize: targetSize)
                            
                            if let imageBase64 = self?.convertImageToBase64(image: resizedImage) {
                                print(imageBase64)
                            }
                        }
                    }
                }
            }
        }
    }
}
