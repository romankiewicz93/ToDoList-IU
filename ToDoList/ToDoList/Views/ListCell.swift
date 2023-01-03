//
//  ListCell.swift
//  ToDoList
//
//  Created by Jonas Romankiewicz on 25.12.22.
//

import Foundation
import UIKit

final class ListCell: UITableViewCell {
    
    let roundCellView: UIView = {
        let bubbleView = UIView()
        bubbleView.backgroundColor = .systemBlue.withAlphaComponent(ViewValues.opacityBackground)
        bubbleView.layer.masksToBounds = true
        bubbleView.layer.cornerRadius = 10
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        return bubbleView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: ViewValues.defaultSizeText)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(roundCellView)
        roundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        roundCellView.leadingAnchor.constraint(lessThanOrEqualTo: contentView.leadingAnchor, constant: 10).isActive = true
        roundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        roundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true

        roundCellView.addSubview(titleLabel)
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: roundCellView.trailingAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: roundCellView.leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: roundCellView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: roundCellView.bottomAnchor, constant: -10).isActive = true
    }
}
