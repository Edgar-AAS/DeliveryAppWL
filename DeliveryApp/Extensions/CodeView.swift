import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAddiotionalConfiguration()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAddiotionalConfiguration()
    }
    
    func setupAddiotionalConfiguration() {}
}
