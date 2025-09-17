import UIKit

class RegionSelectionViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let regions = [
        Region(name: "Vietnam", code: "VN", flag: "🇻🇳"),
        Region(name: "Japan", code: "JP", flag: "🇯🇵"),
        Region(name: "United States", code: "US", flag: "🇺🇸"),
        Region(name: "China", code: "CN", flag: "🇨🇳"),
        Region(name: "South Korea", code: "KR", flag: "🇰🇷"),
        Region(name: "Thailand", code: "TH", flag: "🇹🇭"),
        Region(name: "Singapore", code: "SG", flag: "🇸🇬"),
        Region(name: "Malaysia", code: "MY", flag: "🇲🇾")
    ]
    
    private var selectedRegion: Region?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Region"
        navigationItem.largeTitleDisplayMode = .never
        
        // Add done button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RegionCell")
    }
    
    @objc private func doneButtonTapped() {
        if let selectedRegion = selectedRegion {
            showRegionSelectedAlert(region: selectedRegion)
        } else {
            showNoRegionSelectedAlert()
        }
    }
    
    private func showRegionSelectedAlert(region: Region) {
        let alert = UIAlertController(
            title: "Region Selected",
            message: "You have selected \(region.flag) \(region.name)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Save region selection
            AutoSetupManager.shared.setRegion(region.name)
            
            // Simulate going back to General settings after region selection
            self.navigationController?.popToRootViewController(animated: true)
            
            // Show completion message
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showSetupCompletionMessage()
            }
        })
        
        present(alert, animated: true)
    }
    
    private func showNoRegionSelectedAlert() {
        let alert = UIAlertController(
            title: "No Region Selected",
            message: "Please select a region first",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showSetupCompletionMessage() {
        let alert = UIAlertController(
            title: "Setup Complete",
            message: "Region has been set to Japan. The app will now restart to apply changes.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Restart App", style: .default) { _ in
            // Simulate app restart by going back to main settings
            self.navigationController?.popToRootViewController(animated: true)
            
            // Trigger next step in auto setup
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                AutoSetupManager.shared.checkAndTriggerAutoSetup()
            }
        })
        
        present(alert, animated: true)
    }
}

extension RegionSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath)
        let region = regions[indexPath.row]
        
        cell.textLabel?.text = "\(region.flag) \(region.name)"
        cell.accessoryType = selectedRegion?.code == region.code ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedRegion = regions[indexPath.row]
        tableView.reloadData()
    }
}

struct Region {
    let name: String
    let code: String
    let flag: String
}
