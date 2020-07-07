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
    private var labels: [UILabel] = []
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let label3 = UILabel()
    private let label4 = UILabel()
    private let label5 = UILabel()
    private let label6 = UILabel()
    private let label7 = UILabel()
    
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
        
        labels = [label1, label2, label3, label4, label5, label6, label7]
        let labelTexts: [String] = ["SU", "M", "T", "W", "TH", "F", "SA"]
        for (index, label) in labels.enumerated() {
            label.text = labelTexts[index]
            label.font = UIFont.boldSystemFont(ofSize: 12.0)
            label.textColor = .black
        }
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        trackingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackingLabel)
        
        graphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(graphView)
        
        for label in labels{
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
        }
            
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
        
        var offset: CGFloat = 0
        for (index, label) in labels.enumerated() {
            if index < 4 {
                offset = CGFloat((3 - index) * -40)
            }
            else {
                offset = CGFloat((index - 3) * 40)
            }
            let labelConstraints = [label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: offset),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100),
            label.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor)]
            NSLayoutConstraint.activate(labelConstraints)
        }
    }
}

