//
//  ViewController.swift
//  Flo
//
//  Created by Ike Mattice - Personal on 2/24/17.
//  Copyright © 2017 Ike Mattice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
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
    }
}

