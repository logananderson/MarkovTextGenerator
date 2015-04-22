//
//  MarkovModel.swift
//  MarkovTextGenerator
//
//  Created by Logan Anderson on 4/21/15.
//  Copyright (c) 2015 loganonthemove.com. All rights reserved.
//

import Cocoa

class MarkovModel: NSObject {
    
    private var model:Dictionary<String, Dictionary<String, Int>>;
    private var order:Int;
    private var text:String;
    
    init(text: String, order: Int) {
        self.model = Dictionary<String, Dictionary<String, Int>>();
        self.order = order;
        self.text = text;
        super.init();
        self.model = self.generateModel(text, order: order);
    }
    
    func generateText(length:Int) -> String {
        var currentFragment = text.substringToIndex(advance(self.text.startIndex, self.order));
        var output = String("");
        for i in 0...length-self.order {
            if let newCharacter = self.getNextCharacter(currentFragment) {
                output += newCharacter;
                currentFragment = currentFragment.substringFromIndex(advance(currentFragment.startIndex,1)) + newCharacter;
            }
        }
        return output;
    }
    
    private func getNextCharacter(fragment: String) -> String? {
        var letters = Array<String>();
        if let keys = self.model[fragment]?.keys.array {
            for letter in keys {
                if let times = self.model[fragment]![letter] {
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
    
}
