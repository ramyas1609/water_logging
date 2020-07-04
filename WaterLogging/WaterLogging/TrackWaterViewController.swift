//
//  TrackWaterViewController.swift
//  WaterLogging
//
//

import UIKit

class TrackWaterViewController: UIViewController {

    private let addWaterButton = PushButton()
    private let updateGoalButton = UIButton()
    private let progressLabel = UILabel()
    private let maxNumberOfGlasses: Int = 10

    var count: Int = 0
    // Read from user defualts if available

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

        // Set up the progress label
        progressLabel.textColor = UIColor.black
        progressLabel.font = UIFont.boldSystemFont(ofSize: 15)
        progressLabel.adjustsFontSizeToFitWidth = true
        
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
        updateGoalButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(progressLabel)
        container.addSubview(addWaterButton)
        container.addSubview(updateGoalButton)
        container.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(container)
        
        let progressLabelConstraints = [
            progressLabel.topAnchor.constraint(equalTo: container.topAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: -40),
            progressLabel.trailingAnchor.constraint(equalTo:container.trailingAnchor, constant: 40),
        ]

        NSLayoutConstraint.activate(progressLabelConstraints)

        // Buttons constraints
        let addWaterButtonConstraints = [
            addWaterButton.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 60),
            addWaterButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            addWaterButton.trailingAnchor.constraint(equalTo:container.trailingAnchor),
            addWaterButton.widthAnchor.constraint(equalToConstant: 80),
            addWaterButton.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(addWaterButtonConstraints)
        
        let updateGoalButtonConstraints = [
            updateGoalButton.topAnchor.constraint(equalTo: addWaterButton.bottomAnchor, constant: 60),
            updateGoalButton.leadingAnchor.constraint(equalTo: addWaterButton.leadingAnchor, constant: -20),
            updateGoalButton.trailingAnchor.constraint(equalTo: addWaterButton.trailingAnchor, constant: 20),
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
        count = count + 1
        setLabelText()
        UserDefaults.standard.set(count, forKey: "count")
    }

    @objc private func goalButtonPressed() {
        print("Goal button pressed")
    }
}

