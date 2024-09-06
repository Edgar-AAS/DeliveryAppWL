import UIKit

class FoodDetailsViewController: UIViewController {
    private lazy var customView: FoodDetailsScreen? = {
        return view as? FoodDetailsScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = FoodDetailsScreen()
    }
    
    private let viewModel: FoodDetailsViewModelProtocol
    
    init(viewModel: FoodDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        customView?.delegate = self
        customView?.updateUI(with: viewModel.getFoodDetailsDTO())
    }
}

//MARK: - FoodDetailsViewModel Actions
extension FoodDetailsViewController: FoodDetailsViewModelDelegate {
    func favoriteTogleWith(state: Bool) {
        customView?.updateFavoriteButtonState(state)
    }
    
    func stepperDidChange(dto: StepperDTO) {
        customView?.updateStepper(dto: dto)
    }
}

//MARK: - FoodDetailsScreen Actions
extension FoodDetailsViewController: FoodDetailsScreenDelegate {
    func favoriteButtonDidTapped() {
        viewModel.isFavoriteToggle()
    }
    
    func minusButtonDidTapped() {
        viewModel.decrementFood()
    }
    
    func plusButtonDidTapped() {
        viewModel.incrementFood()
    }
    
    func backButtonDidTapped() {
        viewModel.backToHome()
    }
}
