//
//  FovoritesCollectionViewController.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoritesCollectionViewController: UICollectionViewController {

    // MARK: - Properties

    let viewModel: FavoritesMoviesViewModel

    // MARK: - Initializers

    init(viewModel: FavoritesMoviesViewModel) {
        self.viewModel = viewModel

        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)

        viewModel.updateCompletion = { [weak self] in
            self?.update()
        }

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

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                            for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }

        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel

        return cell
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

    @objc func update() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
