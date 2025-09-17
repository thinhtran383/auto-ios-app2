import UIKit

class MainSettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let settingsItems = [
        SettingsItem(title: "General", icon: "gear", action: .general),
        SettingsItem(title: "Privacy & Security", icon: "hand.raised", action: .privacy)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    private func setupNavigationBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MainSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        let item = settingsItems[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = settingsItems[indexPath.row]
        
        switch item.action {
        case .general:
            let generalVC = GeneralSettingsViewController()
            navigationController?.pushViewController(generalVC, animated: true)
        case .privacy:
            let privacyVC = PrivacyViewController()
            navigationController?.pushViewController(privacyVC, animated: true)
        }
    }
}

struct SettingsItem {
    let title: String
    let icon: String
    let action: SettingsAction
}

enum SettingsAction {
    case general
    case privacy
}
