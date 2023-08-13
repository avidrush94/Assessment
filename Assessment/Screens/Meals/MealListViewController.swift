//
//  MealListViewController.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit
import Alamofire

class MealListViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var meals: [Meal] = [] {
        didSet {
            applyDataSnapshot()
            refreshBackground()
        }
    }
    
    var refreshControl: UIRefreshControl!
    
    var diffableDataSource: UICollectionViewDiffableDataSource<Int, Meal>!
    
    weak var dataRequest: DataRequest!
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: CollectionViewListLayout())
        
        title = "Meals"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// configure navigation bar
        setupNavgiationBar()

        /// configure collectionView
        registerCells()
        setupDiffableDataSource()
        setupRefreshControl()
        refreshBackground()
        
        /// configure search
        setupSearchController()
    }
    
    // MARK: - Actions
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        guard
            let searchController = navigationItem.searchController,
            let searchString = searchController.searchBar.text
        else {
            sender.endRefreshing()
            return
        }

        searchMeals(startingWith: searchString)
    }
    
    @objc private func showProfile(_ sender: UIBarButtonItem) {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Functionaltities
    
    private func setupNavgiationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let profileBarButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle"),
            style: .done,
            target: self,
            action: #selector(showProfile(_:))
        )
        navigationItem.rightBarButtonItem = profileBarButton
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self // Monitor when the search button is tapped.
        
        navigationItem.searchController = searchController
    }
    
    private func registerCells() {
        collectionView.registerNib(forType: MealOverviewCell.self)
    }
    
    private func setupDiffableDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<Int, Meal>(collectionView: self.collectionView) { collectionView, indexPath, meal in
            let cell = collectionView.dequeueReusableCell(ofType: MealOverviewCell.self, for: indexPath)
            cell.configure(with: meal)
            cell.onImageTap = { [weak self] sender in
                guard
                    let self = self,
                    let url = URL(string: meal.thumbnail ?? "")
                else { return }
                
                let sourceFrame = self.view.convert(sender.frame, from: sender.superview)
                
                let vc = ImagePreviewVC(url: url, sourceFrame: sourceFrame)
                self.present(vc, animated: true)
            }
            return cell
        }
        applyDataSnapshot()
    }
    
    private func applyDataSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Meal>()
        snapshot.appendSections([0])
        snapshot.appendItems(meals)
        diffableDataSource.apply(snapshot)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    private func refreshBackground() {
        let searchIsEmpty = navigationItem.searchController?.searchBar.text?.isEmpty ?? true
        
        if meals.isEmpty && searchIsEmpty {
            collectionView.backgroundView = BackgroundView(icon: UIImage(systemName: "magnifyingglass"), message: "Search for meals")
        } else if !searchIsEmpty && meals.isEmpty {
            collectionView.backgroundView = BackgroundView(icon: UIImage(systemName: "questionmark"), message: "We could not find your meal. Let's search something else...")
        } else {
            collectionView.backgroundView = nil
        }
    }

    // MARK: - API
    
    private func searchMeals(startingWith searchString: String) {
        dataRequest?.cancel()
        dataRequest = MealService.fetchMeals(startingWith: searchString) { [weak self] result in
            guard let self = self else { return }
            
            defer {
                self.refreshControl.endRefreshing()
            }
            
            switch result {
            case .success(let success): self.meals = success
            case .failure(let failure): self.meals = []
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let meal = meals[safe: indexPath.row]
        else { return }
        
        let vc = MealDetailsViewController(meal: meal)
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - Search
extension MealListViewController: UISearchControllerDelegate {
    
}

extension MealListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchString = searchController.searchBar.text,
            !searchString.isEmpty
        else {
            meals.removeAll()
            return
        }
        
        searchMeals(startingWith: searchString)
    }
    
}

extension MealListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let searchString = searchBar.text,
            !searchString.isEmpty
        else {
            meals.removeAll()
            return
        }
        
        searchMeals(startingWith: searchString)
    }
    
}
