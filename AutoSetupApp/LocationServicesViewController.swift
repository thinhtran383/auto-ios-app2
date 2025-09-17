import UIKit
import CoreLocation

class LocationServicesViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let locationManager = CLLocationManager()
    
    private var isLocationServicesEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupLocationManager()
        checkLocationServicesStatus()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Location Services"
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
    }
    
    private func checkLocationServicesStatus() {
        isLocationServicesEnabled = CLLocationManager.locationServicesEnabled()
        tableView.reloadData()
    }
    
    @objc private func doneButtonTapped() {
        showLocationServicesAlert()
    }
    
    private func showLocationServicesAlert() {
        let status = isLocationServicesEnabled ? "ENABLED" : "DISABLED"
        let message = "Location Services: \(status)"
        
        let alert = UIAlertController(
            title: "Location Services Settings",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Go back to Privacy settings
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func showLocationPermissionAlert() {
        let alert = UIAlertController(
            title: "Location Permission",
            message: "This app would like to access your location to demonstrate location services settings.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .cancel) { _ in
            self.isLocationServicesEnabled = false
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Allow", style: .default) { _ in
            self.locationManager.requestWhenInUseAuthorization()
        })
        
        present(alert, animated: true)
    }
}

extension LocationServicesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // Main toggle
        case 1:
            return 1 // Permission status
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Location Services"
        case 1:
            return "Permission Status"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Location Services"
            cell.accessoryView = createSwitch(isOn: isLocationServicesEnabled) { [weak self] isOn in
                self?.isLocationServicesEnabled = isOn
                if isOn {
                    self?.showLocationPermissionAlert()
                }
                self?.tableView.reloadData()
            }
            cell.selectionStyle = .none
            
        case 1:
            let status = isLocationServicesEnabled ? "Enabled" : "Disabled"
            cell.textLabel?.text = "Status: \(status)"
            cell.textLabel?.textColor = isLocationServicesEnabled ? .systemGreen : .systemRed
            cell.accessoryType = .none
            cell.selectionStyle = .none
            
        default:
            break
        }
        
        return cell
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

extension LocationServicesViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                self.isLocationServicesEnabled = true
            case .denied, .restricted:
                self.isLocationServicesEnabled = false
            case .notDetermined:
                self.isLocationServicesEnabled = false
            @unknown default:
                self.isLocationServicesEnabled = false
            }
            self.tableView.reloadData()
        }
    }
}
