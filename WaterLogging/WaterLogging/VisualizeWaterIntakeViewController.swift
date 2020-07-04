//
//  VisualizeWaterIntakeViewController.swift
//  WaterLogging
//
//

import UIKit

class VisualizeWaterIntakeViewController: UIViewController {

    // Specifically made public so that the AppTabBarController can set
    // the last graph point in the graph view to today's number of water glasses.
    public let graphView = GraphView()
    private let trackingLabel = UILabel()
    
    static let notificationName = Notification.Name("updateToday")
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: VisualizeWaterIntakeViewController.notificationName, object: nil)
    }
    
    @objc func onNotification(notification: Notification) {
        if let count = notification.userInfo?["data"] as? Int {
            graphView.graphPoints[graphView.graphPoints.count - 1] = count
            graphView.setNeedsDisplay()
        }
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
                                    graphView.widthAnchor.constraint(equalToConstant: 250),
                                    graphView.heightAnchor.constraint(equalToConstant: 250)]
        
        NSLayoutConstraint.activate(graphViewConstraints)
    }
}

