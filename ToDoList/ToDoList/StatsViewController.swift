//
//  StatsViewController.swift
//  ToDoList
//
//  Created by Jake Moskowitz on 9/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit


class StatsViewController: UIViewController {

    @IBOutlet var numTasksLabel: UILabel!
    @IBOutlet var currTimeLabel: UILabel!
    @IBOutlet var coolButton: UIButton!
    @IBOutlet var very: UILabel!
    var delegate: ToDoTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let time = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        currTimeLabel.text = time
        very.hidden = true
        coolButton.layer.cornerRadius = 7.0
        let num = delegate?.getCompletion()
        numTasksLabel.text = String(num!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressCoolButton() {
        very.hidden = false
    }


}
