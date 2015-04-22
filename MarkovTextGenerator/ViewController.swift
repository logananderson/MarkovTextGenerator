//
//  ViewController.swift
//  MarkovTextGenerator
//
//  Created by Logan Anderson on 4/21/15.
//  Copyright (c) 2015 loganonthemove.com. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var string = "Sidecar is building the largest transportation marketplace powered by everyday people. The company offers three services: Sidecar, a ride app which connects riders with everyday drivers in their personal vehicle; Sidecar Shared Rides, a discounted instant carpooling app; and Sidecar Deliveries, a breakthrough innovation that combines people and packages for the fastest and lowest cost same-day delivery solution. Sidecar is currently available in ten U.S. markets and has completed millions of rides. Founded in 2012 and based in San Francisco, Sidecar is backed by top-tier investors including Union Square Ventures, Avalon Ventures, Lightspeed Venture Partners, Google Ventures and Sir Richard Branson. Jahan Khanna is a nationally recognized transportation technology pioneer. As a University of Michigan Student, Jahan was lead programmer on the “Magic Bus Project”, a transit application that told passengers how long they’d wait for the next bus. This school project became Shepherd Intelligent Systems, a transportation software company for public transit, taxi, limo, school and shuttle bus fleets that was later adopted by universities nationwide. Under Jahan’s leadership, Sidecar’s engineering team has developed a dynamic, intuitive and scalable platform that has matched millions of rides nationwide. Sunil is a veteran entrepreneur, champion of climate reform and disrupter of the status quo. Under his leadership Sidecar has expanded from the first instant rideshare company in San Francisco to cities nationwide. His passion to reinvent transportation dates back over a decade. In 2011, Sunil successfully lobbied the California legislature to pass a law for peer-to-peer car sharing, a law that has since been adopted by Oregon and Washington. In 2002, Sunil was issued a patent, now held by Sidecar, for using smartphones to coordinate transportation. As an investor and partner at Spring Ventures, Sunil coined the term “cleanweb” which marries information technology and the social web with green initiatives. Sidecar is the realization of Sunil’s cleanweb vision. Sunil also co-founded and led Brightmail, the leading anti-spam company later sold to Symantec and FreeLoader, the first web based push technology service.";
        var hereWeGo = self.generateText(string, order: 4, length: 400);
        print(hereWeGo);
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func generateModel(text: String, order: Int) -> Dictionary<String, Dictionary<String, Int>> {
        var model:Dictionary<String, Dictionary<String, Int>> = Dictionary<String, Dictionary<String, Int>>();
        for i in 0...count(text)-order-1 {
            var fragment = text.substringWithRange(Range<String.Index>(start: advance(text.startIndex, i), end: advance(text.startIndex, i+order)));
            var nextLetter = String(text[advance(text.startIndex, i+order)]);
            if (model[fragment] == nil) {
                model[fragment] = Dictionary<String, Int>();
            }
            if model[fragment]![nextLetter] == nil {
                model[fragment]![nextLetter] = 1;
            } else {
                model[fragment]![nextLetter]!++;
            }
            
        }
        return model;
    }
    
    private func getNextCharacter(model: Dictionary<String, Dictionary<String, Int>>, fragment: String) -> String? {
        var letters = Array<String>();
        if let keys = model[fragment]?.keys.array {
            for letter in keys {
                if let times = model[fragment]![letter] {
                    for i in 0...times {
                        letters.append(letter);
                    }
                }
            }
        }
        if letters.count > 0 {
            return letters[Int(arc4random_uniform(UInt32(letters.count)))];
        } else {
            return nil;
        }
    }
    
    private func generateText(text: String, order:Int, length:Int) -> String {
        let model:Dictionary<String, Dictionary<String, Int>> = self.generateModel(text, order: order);
        var currentFragment = text.substringToIndex(advance(text.startIndex, order));
        var output = String("");
        for i in 0...length-order {
            if let newCharacter = self.getNextCharacter(model, fragment: currentFragment) {
                output += newCharacter;
                currentFragment = currentFragment.substringFromIndex(advance(currentFragment.startIndex,1)) + newCharacter;
            }
        }
        return output;
    }

}

