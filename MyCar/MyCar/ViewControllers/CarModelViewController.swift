//
//  CarModelViewController.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import UIKit
import RxSwift
import RxCocoa


class CarModelViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: CarModelsViewModel!
    var manufacturer: Manufacture!
    
    private let bag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        viewModel.fetchCarModels(manufacturerID: manufacturer.id)
    }
    
    private func setupUI() {
        title = "Car Model"
        titleLabel.text = "Select Car Model"
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MyCarTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCarTableViewCell")
        tableView.layer.cornerRadius = 15
    }
    
    private func setupBinding() {
        viewModel.allModels.bind(to: tableView.rx.items(cellIdentifier: "MyCarTableViewCell", cellType: MyCarTableViewCell.self)) { row, data, cell in
            cell.nameLabel.text = data.name
            cell.setupColor(isEven: row % 2 == 0)
        }.disposed(by: bag)
        
        tableView.rx.willDisplayCell.subscribe(onNext: { [weak self] cell, indexPath in
            guard let weakSelf = self else {return}
            if weakSelf.viewModel.allModels.value.count - 1 == indexPath.row
                && weakSelf.viewModel.isLoading.value == false {
                weakSelf.viewModel.fetchCarModels(manufacturerID: weakSelf.manufacturer.id)
            }
            
        }).disposed(by: bag)
        
        tableView.rx.modelSelected(CarModel.self)
            .subscribe(onNext: { [weak self] (model) in
                self?.showFinalAlert(model: model)
            }).disposed(by: bag)
        
        viewModel.isLoading.subscribe(onNext: { [weak self] isLoading in
            self?.indicator.isHidden = !isLoading
            if isLoading {
                self?.indicator.startAnimating()
            } else {
                self?.indicator.stopAnimating()
            }
        }).disposed(by: bag)
        
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
    
    private func showFinalAlert(model: CarModel) {
        let message = "You have selected \(manufacturer.name)'s \(model.name) model"
        let alert = UIAlertController(title: "Thank you!", message:message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
