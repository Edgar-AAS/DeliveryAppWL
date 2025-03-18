import UIKit

final class CartViewController: UIViewController {
    private lazy var customView: CartScreenView = {
        guard let view = view as? CartScreenView else {
            fatalError("View is not of type CartScreenView")
        }
        return view
    }()
    
    private let cartItems: [CartItem] = [
        CartItem(name: "Burger With ", price: 12.23, quantity: 1, image: UIImage(named: "burguer1")),
        CartItem(name: "Ordinary Burgers", price: 12.23, quantity: 2, image: UIImage(named: "burger2")),
        CartItem(name: "Ordinary Burgers", price: 12.23, quantity: 1, image: UIImage(named: "burger3"))
    ]
    
    private let recommendedItems: [RecommendedItem] = [
        RecommendedItem(name: "Ordinary Burgers", price: 17.23, rating: 4.9, distance: "190m", image: UIImage(named: "burger4")),
        RecommendedItem(name: "Ordinary Burgers", price: 17.23, rating: 4.9, distance: "190m", image: UIImage(named: "burger5"))
    ]
    
    override func loadView() {
        super.loadView()
        view = CartScreenView()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        customView.setupTableViewProtocols(delegate: self, dataSource: self)
        customView.setupCollectionViewProtocols(delegate: self, dataSource: self)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.reuseIdentifier, for: indexPath) as? CartItemCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: cartItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedItemCell.reuseIdentifier, for: indexPath) as? RecommendedItemCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: recommendedItems[indexPath.item])
        return cell
    }
}
