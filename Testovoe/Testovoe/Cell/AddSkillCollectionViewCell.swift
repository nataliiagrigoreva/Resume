//
//  AddSkillCollectionViewCell.swift
//  Testovoe
//
//  Created by Nataly on 01.08.2023.
//

import Foundation
import UIKit

class AddSkillCollectionViewCell: UICollectionViewCell {
    static let identifier = "AddSkillCell"
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить навык", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
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
        contentView.addSubview(addButton)
    }
}
