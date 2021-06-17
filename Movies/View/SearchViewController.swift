//
//  SearchViewController.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class SearchViewController: UITableViewController, UISearchResultsUpdating {
    
    //    MARK: - Properties
    let viewModel: MoviesViewModel
    let searchBar = UISearchController()
    
    //    MARK: - Initializers

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchResultsUpdater = self
        
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        setupLayout()
    }
    
    //    MARK:  - Search result
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    //    MARK:  - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    MARK: - UISetup
    
    private func setupLayout() {
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchBar.searchBar
    }
}
