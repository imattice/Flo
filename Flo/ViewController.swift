//
//  ViewController.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 2/24/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//IBOUTLETS
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    //label outlets
    @IBOutlet weak var averageWaterConsumed: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBOutlet weak var medalView: MedalView!
    
    var isGraphViewShowing = false
    
//OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
        
        checkTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupGraphDisplay() {
        //Use 7 days for graph - could use any number but labels and sample data are set up for 7 days
        let noOfDays: Int = 7
        
        //replace last day with today's actual date
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        
        //indicate that thegraph needs to be redrawn
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\((graphView.graphPoints).max())"
        
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterConsumed.text = "\(average)"
        
        //set up labels
        //day of the week labels are set up in the storyboard with tags.  Today is the last day of the array and needs to be read backwards
        
        //get todays day number
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let componentOptions = Set<Calendar.Component>([.weekday])
        let components = calendar.dateComponents(componentOptions, from: Date())
        var weekday = components.weekday! as Int
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        
        //set up the day name labels with correct day
        for i in (1...days.count).reversed() {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                print(weekday)
                labelView.text = days[weekday]
                weekday -= 1

                if weekday < 0 {
                    weekday = days.count - 1
                }
            }
        }
    }
    
    func checkTotal() {
        if counterView.counter >= 8 {
            medalView.showMedal(show: true)
        } else {
            medalView.showMedal(show: false)
        }
    }
    
//IBACTIONS
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
        
        checkTotal()
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
            setupGraphDisplay()
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 1.0,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
}

