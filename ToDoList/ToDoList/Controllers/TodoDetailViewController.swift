//
//  TodoDetailViewController.swift
//  ToDoList
//
//  Created by Jonas Romankiewicz on 02.01.23.
//

import Foundation
import UIKit

class ToDoDetailViewController: UIViewController {
    var item: ToDoListItem!

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: ViewValues.defaultSizeText)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.preferredMaxLayoutWidth = 300
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: ViewValues.defaultSizeText)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Mein ToDo"
        if let date = item.createAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
        } else {
            dateLabel.text = "No date available"
        }
        titleLabel.text = item.name
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
    }
}
