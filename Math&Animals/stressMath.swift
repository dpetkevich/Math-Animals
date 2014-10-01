//
//  stressMath.swift
//  stressMath
//
//  Created by Daniel Petkevich on 9/4/14.
//  Copyright (c) 2014 Daniel Petkevich. All rights reserved.
//

import Foundation

class stressMathModel {
    
    var percentage: Double
    var operand: Double
    var correctResult: Double {
        get {
            return percentage*operand
        }
    
    }
    
    init() {
        percentage=Double(((arc4random_uniform(20)+1)*5))/100
        println(percentage)
        operand=Double((arc4random_uniform(100)+1)/10)*pow(10,Double((arc4random() % 8)+2));

    }
   
    func isCorrect(submission:Double) -> Bool {
        if (correctResult==submission){
            return true;
        }
        else{
            return false;
        }
    }
    
    
}