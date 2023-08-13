//
//  MealDetailsViewController.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit
import Kingfisher

class MealDetailsViewController: UICollectionViewController {

    // MARK: - Properties
    
    let meal: Meal
    
    var mealDetails: Meal? {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    init(meal: Meal) {
        self.meal = meal
        super.init(collectionViewLayout: MealDetailLayout())
        
        title = "Details"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        fetchMealDetails()
    }
    
    // MARK: - Functionalities
    
    private func registerCells() {
        collectionView.registerNib(forType: MealBasicDetailCell.self)
        collectionView.registerNib(forType: MealIngredientsCell.self)
        collectionView.registerNib(forType: MealMeasuresCell.self)
        collectionView.registerNib(forType: MealDetailSectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    // MARK: - API
    
    private func fetchMealDetails() {
        
        MealService.fetchMealDetails(with: meal.id) { result in
            switch result {
            case .success(let meal): self.mealDetails = meal
            case .failure(let error): self.alert(message: error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 +
        (mealDetails?.ingredients.isEmpty ?? true ? 0 : 1) +
        (mealDetails?.measures.isEmpty ?? true ? 0 : 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return mealDetails?.ingredients.count ?? 0
        case 2: return mealDetails?.measures.count ?? 0
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch (indexPath.section, kind) {
        case (1, UICollectionView.elementKindSectionHeader):
            let view = collectionView.dequeueReusableHeaderView(
                ofKind: kind,
                ofType: MealDetailSectionHeaderView.self,
                for: indexPath
            )
            view.set(header: "Ingredients")
            return view
            
        case (2, UICollectionView.elementKindSectionHeader):
            let view = collectionView.dequeueReusableHeaderView(
                ofKind: kind,
                ofType: MealDetailSectionHeaderView.self,
                for: indexPath
            )
            view.set(header: "Measures")
            return view
            
        default: return .init()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0: return mealDetailsCell(in: collectionView, at: indexPath)
        case 1: return ingredientCell(in: collectionView, at: indexPath)
        case 2: return measureCell(in: collectionView, at: indexPath)
        default: return .init()
        }
    }
    
    private func mealDetailsCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> MealBasicDetailCell {
        let cell = collectionView.dequeueReusableCell(ofType: MealBasicDetailCell.self, for: indexPath)
        cell.configure(with: mealDetails ?? meal)
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
    
    private func ingredientCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> MealIngredientsCell {
        let cell = collectionView.dequeueReusableCell(ofType: MealIngredientsCell.self, for: indexPath)
        let meal = mealDetails ?? meal
        cell.configure(with: meal.ingredients[safe: indexPath.row] ?? "")
        return cell
    }
    
    private func measureCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> MealMeasuresCell {
        let cell = collectionView.dequeueReusableCell(ofType: MealMeasuresCell.self, for: indexPath)
        let meal = mealDetails ?? meal
        cell.configure(with: meal.measures[safe: indexPath.row] ?? "")
        return cell
    }
    
}
