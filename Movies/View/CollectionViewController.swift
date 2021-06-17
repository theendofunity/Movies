//
//  CollectionViewController.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    //    MARK: - Properties
    
    let viewModel: MoviesViewModelType
    
    //    MARK: - Initializers
    
    init(viewModel: MoviesViewModelType) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        self.collectionView!.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: LoadingCollectionViewCell.identifier)
        
        loadMoreData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = viewModel.numberOfItems()
        if numberOfItems == 0 { //data did not loading now
            return numberOfItems
        }
        return viewModel.numberOfItems() + 1 // +1 -- loading cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.item == viewModel.numberOfItems() {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.identifier, for: indexPath) as? LoadingCollectionViewCell else { return UICollectionViewCell() }
            print("loading cell")
            cell.activityIndicator.startAnimating()
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item >= viewModel.numberOfItems() {
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.loadMoreData()
            }
        }
    }
    // MARK: - UI Configuration
    
    private func setupLayout() {
        collectionView.backgroundColor = .white
        let itemsAtRow: CGFloat = 2
        let inset: CGFloat = 20
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumInteritemSpacing = inset
        layout.minimumLineSpacing = inset
        
        let paddingWidth = inset * (itemsAtRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthForItem = availableWidth / itemsAtRow
        layout.itemSize = CGSize(width: widthForItem, height: widthForItem)
    }
    
    //    MARK: - Data loading
    
    private func loadMoreData() {
        viewModel.loadMovies { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}
