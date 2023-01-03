//
//  TodoDetail.swift
//  ToDoList
//
//  Created by Jonas Romankiewicz on 02.01.23.
//
import Foundation
import UIKit

class ToDoDetail: UIView {
    
    private let nameLabel = UILabel()
    private let createAtLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(nameLabel)
        self.addSubview(createAtLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        createAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            createAtLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            createAtLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            createAtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with item: ToDoListItem) {
        nameLabel.text = item.name
        createAtLabel.text = "Erstellt am \(item.createAt ?? Date())"
    }
}
