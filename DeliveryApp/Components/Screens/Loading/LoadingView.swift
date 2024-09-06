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
        indicator.color = Colors.primaryColor
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func startLoading() {
        isHidden = false
        isUserInteractionEnabled = false
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        isHidden = true
        loadingIndicator.stopAnimating()
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
    
    func setupAddiotionalConfiguration() {
        isHidden = true
        backgroundColor = .black.withAlphaComponent(0.6)
    }
}