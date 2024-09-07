import Foundation

protocol EmailVerificationViewModelProtocol {
    func sendPasswordReset()
    func checkOtpCode(_ otpCode: String)
    func goToResetPassword()
    var getEmailAdress: String { get }
    var timerOutput: Observable<String> { get }
    var isTimerRunning: Observable<Bool> { get }
}

class EmailVerificationViewModel: EmailVerificationViewModelProtocol {
    private let coordinator: Coordinator
    private let user: User?
    
    private var totalTime = 10
    private var timer: Timer?
    
    var timerOutput: Observable<String> = Observable(value: nil)
    var isTimerRunning: Observable<Bool> = Observable(value: false)
    
    init(coordinator: Coordinator, user: User) {
        self.coordinator = coordinator
        self.user = user
        self.timerOutput.setValue("02:30")
    }
    
    deinit {
        timer = nil
    }
    
    var getEmailAdress: String {
        return user?.email ?? ""
    }
    
    func checkOtpCode(_ otpCode: String) {
        if otpCode.count == 4 {
            let isNumber = otpCode.allSatisfy { $0.isNumber }
            isNumber ? print("otpCode pass: \(otpCode)") : print("Error")
        }
    }
    
    func sendPasswordReset() {
        startOtpTimer()
    }
    
    private func startOtpTimer() {
        self.isTimerRunning.setValue(true)
        timer?.invalidate()
        timer = nil
        totalTime = 150
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            timeFormatted(totalTime)
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                self.isTimerRunning.setValue(false)
            }
        }
    }
    
    func goToResetPassword() {
        coordinator.eventOcurred(type: .goToResetPassword)
    }
    
    private func timeFormatted(_ totalSeconds: Int) {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let timeFormatted = String(format: "%02d:%02d", minutes, seconds)
        self.timerOutput.setValue(timeFormatted)
    }
    
    func goToHome() {
        coordinator.eventOcurred(type: .goToHome)
    }
}
