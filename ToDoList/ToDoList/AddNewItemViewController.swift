//
//  AddNewItemViewController.swift
//  ToDoList
//
//  Created by Jake Moskowitz on 9/30/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailsTextField: UITextField!
    @IBOutlet var betteWhite: UIImageView!
    @IBOutlet var bettyLabel: UILabel!
    var info: NSMutableArray!
    var colorString: String!
    var betty: UIImage!
    var delegate: ToDoTableViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 7.0
        cancelButton.layer.cornerRadius = 7.0
        detailsTextField.layer.cornerRadius = 7.0
        titleTextField.layer.cornerRadius = 7.0
        titleTextField.becomeFirstResponder()
        titleTextField.text = ""
        detailsTextField.text = ""
        
        betty = UIImage(named: "BettyWhite1")
        betteWhite.image = betty
        betteWhite.layer.cornerRadius = 60.0
        betteWhite.layer.masksToBounds = true
        betteWhite.userInteractionEnabled = true
        bettyLabel.hidden = true
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didPressBettyButton")
        betteWhite.addGestureRecognizer(singleTap)
        self.view.addSubview(betteWhite)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didPressCancelButton() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func didPressDoneButton() {
        if titleTextField.text != "" {
            let titleString = titleTextField.text!
            let detailsString = detailsTextField.text!
            colorString = "grey"
            info = [titleString, detailsString, colorString, ""]
            delegate?.addedInfo(info)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func didPressBettyButton() {
        bettyLabel.hidden = false
    }
    
}

