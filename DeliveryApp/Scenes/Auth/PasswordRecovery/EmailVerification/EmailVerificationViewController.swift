import UIKit

class EmailVerificationViewController: UIViewController {
    private lazy var customView: EmailVerificationScreen? = {
        return view as? EmailVerificationScreen
    }()
    
    private var otpCode: [String] = Array(repeating: "", count: 4)
    
    private let viewModel: EmailVerificationViewModelProtocol
    
    init(viewModel: EmailVerificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = EmailVerificationScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        customView?.setupTextFieldsDelegate(delegate: self)
        customView?.delegate = self
        customView?.resendCodeButton.addTarget(self, action: #selector(resendButtonTap), for: .touchUpInside)
        customView?.continueButton.addTarget(self, action: #selector(continueButtonTap), for: .touchUpInside)
        customView?.appendEmail(email: viewModel.getEmailAdress)
    }
    
    private func bindViewModel() {
        viewModel.timerOutput.bind { [weak self] timer in
            DispatchQueue.main.async {
                self?.customView?.cowntdownLabel.text = timer
            }
        }
        
        viewModel.isTimerRunning.bind { [weak self] isTimerRunning in
            guard let isTimerRunning = isTimerRunning else { return }
            guard let self else { return }
            isTimerRunning ? self.customView?.disableResendButton() : self.customView?.enableResendButton()
        }
    }
    
    @objc private func resendButtonTap() {
        viewModel.sendPasswordReset()
    }
    
    @objc private func continueButtonTap() {
        let otpFullCode = otpCode.joined()
        viewModel.checkOtpCode(otpFullCode)
    }
}

// MARK: - UITextFieldDelegate
extension EmailVerificationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if updatedText.count > 1 {
            let lastUpdate = String(updatedText.suffix(1))
            textField.text = lastUpdate
            updateOtpCode(for: textField, with: lastUpdate)
            return false
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        updateOtpCode(for: textField, with: text)
    }
    
    private func updateOtpCode(for textField: UITextField, with text: String) {
        guard let customView = customView else { return }
        
        switch textField {
        case customView.receiveCodeTextField1:
            otpCode[0] = text
            customView.receiveCodeTextField2.becomeFirstResponder()
        case customView.receiveCodeTextField2:
            otpCode[1] = text
            customView.receiveCodeTextField3.becomeFirstResponder()
        case customView.receiveCodeTextField3:
            otpCode[2] = text
            customView.receiveCodeTextField4.becomeFirstResponder()
        case customView.receiveCodeTextField4:
            otpCode[3] = text
        default:
            return
        }
        
        let otpFullCode = otpCode.joined()
        viewModel.checkOtpCode(otpFullCode)
    }
}


//MARK: - Delegate Actions
extension EmailVerificationViewController: EmailVerificationScreenDelegateProtocol {
    func continueButtonDidTapped() {
        
    }
}
