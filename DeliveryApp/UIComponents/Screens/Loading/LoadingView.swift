import UIKit

final class LoadingView: UIView, CodeView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)  
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = Colors.primary
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func handleLoading(with state: LoadingStateModel) {
        let isLoading = state.isLoading
        isHidden = !isLoading
        isUserInteractionEnabled = !isLoading
        
        if isLoading {
            alpha = 0
            loadingIndicator.startAnimating()
        
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func buildViewHierarchy() {
        addSubview(loadingIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        isHidden = true
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}
