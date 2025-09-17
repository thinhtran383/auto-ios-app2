import UIKit

class DateTimeViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var isAutoTimezoneEnabled = true
    private var selectedTimezone = "Tokyo"
    
    private let timezones = [
        "Tokyo",
        "Seoul", 
        "Shanghai",
        "Hong Kong",
        "Singapore",
        "Bangkok",
        "Jakarta",
        "Manila"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Date & Time"
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DateTimeCell")
    }
    
    @objc private func doneButtonTapped() {
        showDateTimeSettingsAlert()
    }
    
    private func showDateTimeSettingsAlert() {
        let autoStatus = isAutoTimezoneEnabled ? "ON" : "OFF"
        let message = "Auto Timezone: \(autoStatus)\nSelected Timezone: \(selectedTimezone)"
        
        let alert = UIAlertController(
            title: "Date & Time Settings",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Go back to General settings
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func showTimezoneSelection() {
        let alert = UIAlertController(
            title: "Select Timezone",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        for timezone in timezones {
            alert.addAction(UIAlertAction(title: timezone, style: .default) { _ in
                self.selectedTimezone = timezone
                self.tableView.reloadData()
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // For iPad
        if let popover = alert.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        present(alert, animated: true)
    }
}

extension DateTimeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // Auto timezone toggle
        case 1:
            return isAutoTimezoneEnabled ? 0 : 1 // Timezone selection (only when auto is off)
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Time Zone"
        case 1:
            return isAutoTimezoneEnabled ? nil : "Manual Timezone"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateTimeCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Set Automatically"
            cell.accessoryView = createSwitch(isOn: isAutoTimezoneEnabled) { [weak self] isOn in
                self?.isAutoTimezoneEnabled = isOn
                self?.tableView.reloadData()
            }
            cell.selectionStyle = .none
            
        case 1:
            cell.textLabel?.text = selectedTimezone
            cell.accessoryType = .disclosureIndicator
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            showTimezoneSelection()
        }
    }
    
    private func createSwitch(isOn: Bool, action: @escaping (Bool) -> Void) -> UISwitch {
        let switchControl = UISwitch()
        switchControl.isOn = isOn
        switchControl.addAction(UIAction { _ in
            action(switchControl.isOn)
        }, for: .valueChanged)
        return switchControl
    }
}
