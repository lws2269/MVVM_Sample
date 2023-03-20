//
//  UserCell.swift
//  MVVM_sample
//
//  Created by leewonseok on 2023/03/16.
//

import UIKit
import Combine

class UserCell: UITableViewCell {
    static let identifier = "UserCell"
    
    var cancellabels: Set<AnyCancellable>?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(ageLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            ageLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            ageLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
