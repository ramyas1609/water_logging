//
//  TrackWaterViewController.swift
//  WaterLogging
//
//

import UIKit

class TrackWaterViewController: UIViewController {

    private let addWaterButton = PushButton()
    private let subtractWaterButton = PushButton()
    private let updateGoalButton = UIButton()
    private let progressLabel = UILabel()
    
    var maxNumberOfGlasses: Int = 10
    var count: Int = 0

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Set Up

    private func setUp() {
        view.backgroundColor = .systemBackground

        // Set up update goal button
        updateGoalButton.setTitle("Set Daily Goal", for: .normal)
        updateGoalButton.addTarget(self, action: #selector(goalButtonPressed), for: .touchUpInside)
        updateGoalButton.backgroundColor = .lightGray
        updateGoalButton.layer.cornerRadius = 5
        updateGoalButton.layer.borderWidth = 1
        updateGoalButton.layer.borderColor = UIColor.black.cgColor
        
        
        // Set up add water button
        addWaterButton.addTarget(self, action: #selector(addWaterButtonPressed), for: .touchUpInside)
        
        // Set up subtract water button
        subtractWaterButton.fillColor = UIColor.orange
        subtractWaterButton.isAdd = false
        subtractWaterButton.addTarget(self, action: #selector(subtractWaterButtonPressed), for: .touchUpInside)

        // Set up the progress label
        progressLabel.textColor = UIColor.black
        progressLabel.font = UIFont.boldSystemFont(ofSize: 15)
        progressLabel.adjustsFontSizeToFitWidth = true
        
        // Read count from user defaults if available
        count = UserDefaults.standard.integer(forKey: "count")
        setLabelText()

        setUpConstraints()
    }

    private func setLabelText() {
         progressLabel.text = "Today's progress    \(count)/\(maxNumberOfGlasses)"
    }

    private func setUpConstraints() {
        let container = UIView()
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addWaterButton.translatesAutoresizingMaskIntoConstraints = false
        subtractWaterButton.translatesAutoresizingMaskIntoConstraints = false
        updateGoalButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(progressLabel)
        container.addSubview(addWaterButton)
        container.addSubview(subtractWaterButton)
        container.addSubview(updateGoalButton)
        container.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(container)
        
        // Progress display constraints
        let progressLabelConstraints = [
            progressLabel.topAnchor.constraint(equalTo: container.topAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: -40),
            progressLabel.trailingAnchor.constraint(equalTo:container.trailingAnchor, constant: 40),
        ]

        NSLayoutConstraint.activate(progressLabelConstraints)

        // Plus sign constraints
        let addWaterButtonConstraints = [
            addWaterButton.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 40),
            addWaterButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            addWaterButton.trailingAnchor.constraint(equalTo:container.trailingAnchor),
            addWaterButton.widthAnchor.constraint(equalToConstant: 80),
            addWaterButton.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(addWaterButtonConstraints)
        
        // Minus sign constraints
        let subtractWaterButtonConstraints = [
            subtractWaterButton.topAnchor.constraint(equalTo: addWaterButton.bottomAnchor, constant: 40),
            subtractWaterButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            subtractWaterButton.trailingAnchor.constraint(equalTo:container.trailingAnchor),
            subtractWaterButton.widthAnchor.constraint(equalToConstant: 80),
            subtractWaterButton.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(subtractWaterButtonConstraints)
        
        // Update goal button constraints
        let updateGoalButtonConstraints = [
            updateGoalButton.topAnchor.constraint(equalTo: subtractWaterButton.bottomAnchor, constant: 40),
            updateGoalButton.leadingAnchor.constraint(equalTo: subtractWaterButton.leadingAnchor, constant: -20),
            updateGoalButton.trailingAnchor.constraint(equalTo: subtractWaterButton.trailingAnchor, constant: 20),
            updateGoalButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(updateGoalButtonConstraints)
        
        // ContainerView constraints
        
        let containerConstraints = [container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                    container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                    container.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor),
                                    container.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
                                    container.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor),
                                    container.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor),
                                    ]
        
        NSLayoutConstraint.activate(containerConstraints)
        
    }

    // Actions

    @objc private func addWaterButtonPressed() {
        if count + 1 <= maxNumberOfGlasses {
            count = count + 1
            setLabelText()
            UserDefaults.standard.set(count, forKey: "count")
            NotificationCenter.default.post(name: VisualizeWaterIntakeViewController.notificationName, object: nil, userInfo:["data": count])
        }
    }
    
    @objc private func subtractWaterButtonPressed() {
        if count - 1 >= 0 {
            count = count - 1
            setLabelText()
            UserDefaults.standard.set(count, forKey: "count")
            NotificationCenter.default.post(name: VisualizeWaterIntakeViewController.notificationName, object: nil, userInfo:["data": count])
        }
    }

    @objc private func goalButtonPressed() {
        let alert = UIAlertController(title: "Enter Water Goal", message: "Enter a number", preferredStyle: .alert)

        // add a text field
        alert.addTextField { (textField) in
            textField.text = "0"
            textField.keyboardType = .numberPad
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let number = Int(alert!.textFields![0].text!) {
                self.maxNumberOfGlasses = number
                self.setLabelText()
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

