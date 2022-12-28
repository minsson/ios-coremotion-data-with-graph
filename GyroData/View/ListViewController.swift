//
//  ListViewController.swift
//  GyroData
//
//  Created by kjs on 2022/09/16.
//

import UIKit

final class ListViewController: UIViewController {
    private let listViewModel = DefaultListViewModel()
    private let listView = ListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigation()
        setupBinding()
    }
    
    private func setupInitialView() {
        self.view = listView
        listView.backgroundColor = .systemBackground
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    }
    
    private func setupBinding() {
        listViewModel.models.bind { [weak self] _ in
            self?.listView.tableView.reloadData()
        }
    }
    
    private func setupNavigation() {
        let rightButton: UIBarButtonItem = {
             let button = UIBarButtonItem(
                title: "측정",
                style: .plain,
                target: self,
                action: #selector(rightButtonTapped)
             )
             
             return button
         }()
        self.navigationItem.title = "목록"
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func rightButtonTapped() {
        let vc = MeasureViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listViewModel.models.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as! ListViewCell
        cell.setupData(with: listViewModel.models.value[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}
