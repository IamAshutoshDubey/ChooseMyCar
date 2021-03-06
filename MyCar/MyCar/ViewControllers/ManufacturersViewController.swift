//
//  ManufacturersViewController.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class ManufacturersViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: ManufacturersViewModel!
    private let bag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var noMoreDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        viewModel.fetchManufacturers()
    }
    
    private func setupUI() {
        title = " Manufacturers"
        titleLabel.text = "Select Manufacturers"
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MyCarTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCarTableViewCell")
        tableView.layer.cornerRadius = 15
        noMoreDataLabel.text = "No More Data!"
    }
            
    private func setupBinding() {
        viewModel.manufacturers.bind(to: tableView.rx.items(cellIdentifier: "MyCarTableViewCell", cellType: MyCarTableViewCell.self)) { row, data, cell in
            cell.nameLabel.text = data.name
            cell.setupColor(isEven: row % 2 == 0)
        }.disposed(by: bag)
        
        tableView.rx.willDisplayCell.subscribe(onNext: { [weak self] cell, indexPath in
            guard let weakSelf = self else {return}
            if weakSelf.viewModel.manufacturers.value.count - 1 == indexPath.row
                && weakSelf.viewModel.isLoading.value == false {
                weakSelf.viewModel.fetchManufacturers()
            }
            
        }).disposed(by: bag)
        
        tableView.rx.modelSelected(Manufacture.self)
            .subscribe(onNext: { [weak self] (model) in
                guard let weakSelf = self else {return}
                weakSelf.viewModel.manufacturerSelected(source: weakSelf, manufacture: model)
            }).disposed(by: bag)
        
        viewModel.isLoading.subscribe(onNext: { [weak self] isLoading in
            self?.indicator.isHidden = !isLoading
            if isLoading {
                self?.indicator.startAnimating()
            } else {
                self?.indicator.stopAnimating()
            }
        }).disposed(by: bag)
        
        viewModel.noMoreFetch.map{!$0}.bind(to: noMoreDataLabel.rx.isHidden).disposed(by: bag)
        
        viewModel.errorObservable.subscribe(onNext: { [weak self] message in
            self?.showErrorAlert(message)
        }).disposed(by: bag)
    }
    
    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message:message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}


