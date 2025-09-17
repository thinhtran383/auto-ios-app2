import UIKit

class LanguageRegionViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let languageRegionItems = [
        LanguageRegionItem(title: "Region", icon: "globe", action: .region)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Language & Region"
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageRegionCell")
    }
}

extension LanguageRegionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageRegionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageRegionCell", for: indexPath)
        let item = languageRegionItems[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = languageRegionItems[indexPath.row]
        
        switch item.action {
        case .region:
            let regionVC = RegionSelectionViewController()
            navigationController?.pushViewController(regionVC, animated: true)
        }
    }
}

struct LanguageRegionItem {
    let title: String
    let icon: String
    let action: LanguageRegionAction
}

enum LanguageRegionAction {
    case region
}
