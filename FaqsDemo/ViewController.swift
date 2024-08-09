//
//  ViewController.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import UIKit

class ViewController: UIViewController {
    private var document: FAQDocument?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        title = "FAQS Demo"
        let button = UIBarButtonItem(title: "Fuente", style: .plain, target: self, action: #selector(didChangeFont))
        navigationItem.rightBarButtonItem = button
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 16),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16)
        ])
        
        tableView.register(EmptyCell.self, forCellReuseIdentifier: EmptyCell.identifier)
        tableView.register(ParagraphCell.self, forCellReuseIdentifier: ParagraphCell.identifier)
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(TableTVCell.self, forCellReuseIdentifier: TableTVCell.identifier)
        document = loadDocument()
        tableView.reloadData()
    }
    
    func loadDocument() -> FAQDocument? {
        guard let url = Bundle.main.url(forResource: "faq-example", withExtension: "json"),
              let jsonData = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            return nil
        }
        
        do {
            let document = try JSONDecoder().decode(FAQDocument.self, from: jsonData)
            return document
        } catch let error {
            return nil
        }
    }
    
    @objc
    func didChangeFont() {
        let alertController = UIAlertController(title: "Cambiar fuente", message: "Elige una fuente", preferredStyle: .actionSheet)
        let fonts = [Fonts.RedHatDisplayRegular, Fonts.RobotoRegular, Fonts.PoppinsRegular, Fonts.systemFont]
        fonts.forEach { font in
            let title = FontSingleton.shared.selectedFont == font ? "\(font.rawValue) ✓" : font.rawValue
            let alertaction = UIAlertAction(title: title, style: .default) { [weak self] _ in
                FontSingleton.shared.selectedFont = font
                FontSingleton.shared.font = font.getFont(withSize: 14)
                self?.tableView.reloadData()
                alertController.dismiss(animated: true)
            }
            alertController.addAction(alertaction)
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let document else { return 0 }
        return document.children.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let document else { return EmptyCell() }
        let element = document.children[indexPath.section]
        
        switch element {
        case .paragraph(let element):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParagraphCell.identifier, for: indexPath) as? ParagraphCell else {
                return UITableViewCell()
            }
            cell.configure(with: element)
            return cell
        case .list(let element):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: element)
            
            return cell
        case .image(let element):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: element)
            
            return cell
        case .table(let element):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableTVCell.identifier, for: indexPath) as? TableTVCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: element)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.identifier, for: indexPath) as? EmptyCell else {
                return UITableViewCell()
            }
            
            return cell
        }
    }
    
    
}
