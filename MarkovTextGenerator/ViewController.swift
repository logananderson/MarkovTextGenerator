//
//  ViewController.swift
//  MarkovTextGenerator
//
//  Created by Logan Anderson on 4/21/15.
//  Copyright (c) 2015 loganonthemove.com. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var entryTextView: NSTextView!
    @IBOutlet var outputTextView: NSTextView!
    @IBOutlet weak var orderTextField: NSTextField!
    @IBOutlet weak var lengthTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func convertClicked(sender: AnyObject) {
        if self.entryTextView.string == "" {
            self.entryTextView.string = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.";
        }
        if self.orderTextField.stringValue == "" {
            self.orderTextField.intValue = 5;
        }
        if self.lengthTextField.stringValue == "" {
            self.lengthTextField.intValue = Int32(count(self.entryTextView.string!));
        }
        if let inputString:String = self.entryTextView.string {
            let model:MarkovModel = MarkovModel(text: self.entryTextView.string!, order: Int(self.orderTextField.intValue));
            var length = Int(self.lengthTextField.intValue);
            self.outputTextView.string = model.generateText(length);
        }
    }
}

