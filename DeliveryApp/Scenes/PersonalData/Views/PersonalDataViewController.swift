import UIKit
import PhotosUI

class PersonalDataViewController: UIViewController {
    private lazy var customView: PersonalDataScreen = {
        guard let view = view as? PersonalDataScreen else {
            fatalError("View is not of type PersonalDataScreen")
        }
        return view
    }()
    
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
            if itemprovider.canLoadObject(ofClass: UIImage.self){
                itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async { [weak self] in
                            self?.customView.profileImage = selectedImage
                        }
                    }
                }
            }
        }
    }
}
