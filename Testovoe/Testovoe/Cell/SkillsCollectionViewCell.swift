//
//  SkillsCollectionViewCell.swift
//  Testovoe
//
//  Created by Nataly on 01.08.2023.
//

import UIKit

class SkillsCollectionViewCell: UICollectionViewCell {
    static let identifier = "SkillsCollectionViewCell"
    
    
    let skillLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "edit_icon"), for: .normal) 
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(skillLabel)
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            skillLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            skillLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            skillLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            skillLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
