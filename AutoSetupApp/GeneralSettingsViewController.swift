import UIKit

class GeneralSettingsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let generalItems = [
        GeneralItem(title: "Language & Region", icon: "globe", action: .languageRegion),
        GeneralItem(title: "Date & Time", icon: "clock", action: .dateTime)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "General"
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GeneralCell")
    }
}

extension GeneralSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath)
        let item = generalItems[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = generalItems[indexPath.row]
        
        switch item.action {
        case .languageRegion:
            let languageRegionVC = LanguageRegionViewController()
            navigationController?.pushViewController(languageRegionVC, animated: true)
        case .dateTime:
            let dateTimeVC = DateTimeViewController()
            navigationController?.pushViewController(dateTimeVC, animated: true)
        }
    }
}

struct GeneralItem {
    let title: String
    let icon: String
    let action: GeneralAction
}

enum GeneralAction {
    case languageRegion
    case dateTime
}
