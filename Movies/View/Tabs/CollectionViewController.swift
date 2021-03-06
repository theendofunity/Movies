//
//  CollectionViewController.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    // MARK: - Properties

    let inset: CGFloat = 20

    let viewModel: MoviesViewModelType

    // MARK: - Initializers

    init(viewModel: MoviesViewModelType) {
        self.viewModel = viewModel

        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()

        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self,
                                      forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        self.collectionView!.register(LoadingCollectionViewCell.self,
                                      forCellWithReuseIdentifier: LoadingCollectionViewCell.identifier)

        loadMoreData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.numberOfItems() == 0 {
            return 1
        }

        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 0 {
            return viewModel.numberOfItems()
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.identifier,
                                                                for: indexPath) as? LoadingCollectionViewCell
            else { return UICollectionViewCell() }

            cell.activityIndicator.startAnimating()

            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                            for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }

        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.loadMoreData()
            }
        }
    }

    // MARK: - UI Configuration

    private func setupLayout() {
                collectionView.backgroundColor = .white
                guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
                layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
                layout.minimumInteritemSpacing = inset
                layout.minimumLineSpacing = inset
    }

    // MARK: - Data loading

    private func loadMoreData() {
        viewModel.loadMovies { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemsAtRow: CGFloat

        itemsAtRow = indexPath.section == 0 ? 2 : 1

        let paddingWidth = inset * (itemsAtRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthForItem = availableWidth / itemsAtRow

        if indexPath.section == 0 {
            return CGSize(width: widthForItem, height: widthForItem)
        } else {
            return CGSize(width: widthForItem, height: 50)
        }
    }
}
