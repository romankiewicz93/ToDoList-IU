//
//  ViewController.swift
//  ToDoList
//
//  Created by Jonas Romankiewicz on 22.12.22.
//

import UIKit

class ViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private var models = [ToDoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getAllItems()
    }

    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "ToDo´s"
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.number"), style: .plain, target: self, action: #selector(didTapSort))
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "Neues ToDo",
                                      message: "Wie lautet dein ToDo?",
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Hinzufügen", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }

            self?.createItem(name: text)
        }))

        present(alert, animated: true)
    }

    @objc private func didTapSort() {
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        models.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else {
            fatalError("ListCell is not defined")
        }
        cell.titleLabel.text = model.name
        return cell
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .destructive, title: "Bearbeiten") { [self] _, _, _ in
            let item = models[indexPath.row]

            let alert = UIAlertController(title: "Bearbeiten",
                                          message: "Bearbeite dein ToDo",
                                          preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Speichern", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }

                self?.updateItem(item: item, newName: newName)
            }))

            self.present(alert, animated: true)
        }

        edit.backgroundColor = .purple
        let swipe = UISwipeActionsConfiguration(actions: [edit])
        return swipe
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .destructive, title: "Löschen") { [self] _, _, _ in
            tableView.beginUpdates()
            let item = self.models[indexPath.row]
            self.deleteItem(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        edit.backgroundColor = .red
        let swipe = UISwipeActionsConfiguration(actions: [edit])
        return swipe
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = models[indexPath.row]
        showDetailView(for: selectedItem)
    }

    func showDetailView(for item: ToDoListItem) {
        let toDodetailViewController = ToDoDetailViewController()
        toDodetailViewController.item = item
        navigationController?.pushViewController(toDodetailViewController, animated: true)
    }

    // MARK: - Core Data

    func getAllItems() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // error
        }
    }

    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createAt = Date()
        do {
            try context.save()
            getAllItems()
        } catch {
            // error
        }
    }

    func deleteItem(item: ToDoListItem) {
        context.delete(item)

        do {
            try context.save()
            getAllItems()
        } catch {
            // error
        }
    }

    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName

        do {
            try context.save()
            getAllItems()
        } catch {
            // error
        }
    }
}
