//
//  MyCarTableViewCell.swift
//  MyCar
//
//  Created by Ashutosh Dubey on 05/04/21.
//

import UIKit

class MyCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupColor(isEven: Bool) {
        backgroundColor = isEven ? .darkGray : .lightGray
    }
}
