import UIKit

class PrivacyViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let privacyItems = [
        PrivacyItem(title: "Location Services", icon: "location", action: .locationServices)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Privacy & Security"
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PrivacyCell")
    }
}

extension PrivacyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privacyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyCell", for: indexPath)
        let item = privacyItems[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = privacyItems[indexPath.row]
        
        switch item.action {
        case .locationServices:
            let locationVC = LocationServicesViewController()
            navigationController?.pushViewController(locationVC, animated: true)
        }
    }
}

struct PrivacyItem {
    let title: String
    let icon: String
    let action: PrivacyAction
}

enum PrivacyAction {
    case locationServices
}
