//
//  VisualizeWaterIntakeViewController.swift
//  WaterLogging
//
//

import UIKit

class VisualizeWaterIntakeViewController: UIViewController {

    private let trackingLabel = UILabel()
    private let graphView = GraphView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Set Up

    private func setUp() {
        trackingLabel.text = "Water glasses Vs day of the week"
        view.backgroundColor = .systemBackground
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        trackingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackingLabel)
        
        graphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(graphView)
        // Label constraints
        
        let trackingLabelConstraints = [trackingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                    trackingLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200),
                                    trackingLabel.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor),
                                    trackingLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
                                    trackingLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor),
                                    trackingLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor)]
        
        NSLayoutConstraint.activate(trackingLabelConstraints)
        
        let graphViewConstraints = [graphView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                    graphView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                    graphView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor),
                                    graphView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
                                    graphView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor),
                                    graphView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor),
                                    graphView.widthAnchor.constraint(equalToConstant: 200),
                                    graphView.heightAnchor.constraint(equalToConstant: 200)]
        
        NSLayoutConstraint.activate(graphViewConstraints)
    }
}

