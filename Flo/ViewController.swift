//
//  ViewController.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 2/24/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    //label outlets
    @IBOutlet weak var averageWaterConsumed: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPushButton(button: PushButtonView) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        print(counterView.counter)
        counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            counterViewTap(gesture: nil)
        }
    }
    @IBAction func counterViewTap(gesture: UITapGestureRecognizer?) {
        if isGraphViewShowing {
            //hide Graph
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 1.0,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
        } else {
            //show Graph
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 1.0,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
}

