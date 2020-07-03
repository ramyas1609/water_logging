//
//  TrackWaterViewController.swift
//  WaterLogging
//
//

import UIKit

class TrackWaterViewController: UIViewController {

    private let addWaterButton = PushButton()
    private let updateGoalButton = UIButton()
    private let maxNumberOfGlasses: Int = 10

    var counter: Int = 0 {
      didSet {
        if counter <= maxNumberOfGlasses {
          //the view needs to be refreshed
        }
      }
    }

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

        setUpConstraints()
    }

    private func setUpConstraints() {
        let container = UIView()
        addWaterButton.translatesAutoresizingMaskIntoConstraints = false
        updateGoalButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(addWaterButton)
        container.addSubview(updateGoalButton)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        // Buttons constraints
        let addWaterButtonConstraints = [
            addWaterButton.topAnchor.constraint(equalTo: container.topAnchor),
            addWaterButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            addWaterButton.trailingAnchor.constraint(equalTo:container.trailingAnchor),
            addWaterButton.widthAnchor.constraint(equalToConstant: 120),
            addWaterButton.heightAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(addWaterButtonConstraints)
        
        let updateGoalButtonConstraints = [
            updateGoalButton.topAnchor.constraint(equalTo: addWaterButton.bottomAnchor, constant: 60),
            updateGoalButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            updateGoalButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            updateGoalButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(updateGoalButtonConstraints)
        
        // ContainerView constraints
        
        let containerConstraints = [container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                    container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                    container.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor),
                                    container.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
                                    container.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor),
                                    container.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor)]
        
        NSLayoutConstraint.activate(containerConstraints)
        
    }

    // Actions

    @objc private func addWaterButtonPressed() {
        counter = counter + 1
        print("Counter ", counter)
    }

    @objc private func goalButtonPressed() {
        print("Goal button pressed")
    }

}

