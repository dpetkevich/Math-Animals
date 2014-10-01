//
//  ViewController.swift
//  stressMath
//
//  Created by Daniel Petkevich on 9/4/14.
//  Copyright (c) 2014 Daniel Petkevich. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    //properties
    @IBOutlet var percentLabel : UILabel!
    @IBOutlet var operand : UILabel!
    @IBOutlet var submission : UITextField!
    @IBOutlet var submitButton : UIButton!
    @IBOutlet var correctIndicator : UILabel!
    @IBOutlet var rewardImage: UIImageView!
    
    //events
    @IBOutlet var test: UIView!
    
    var mathProblem = stressMathModel()
    
    
    
    
    @IBAction func calculateTapped(sender : AnyObject) {
        // 1
        var image1 = UIImage.animatedImageWithAnimatedGIFData(NSData(contentsOfURL:NSBundle.mainBundle().URLForResource(String(arc4random_uniform(7)+1), withExtension: ".gif")!))
        
        if mathProblem.isCorrect(Double((submission.text as NSString).doubleValue)) == true
        {
            submission.resignFirstResponder()
            correctIndicator.text="Good."
            rewardImage.image=image1
            
            
            NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("refreshUI"), userInfo: nil, repeats: false)
            
        }
        else{
            correctIndicator.text="Wrong. Get it right this time."
            
        }
        
        
    }
    
    func goToNextCard(){
        UIView.transitionFromView(test, toView: test, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft |
            UIViewAnimationOptions.ShowHideTransitionViews,
            completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI() {
        
        goToNextCard()
        mathProblem = stressMathModel()
        println(mathProblem.correctResult)
        
        rewardImage.image=nil
        submission.text=""
        correctIndicator.text=""
        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
        formatter.maximumFractionDigits = 0
        
        
        percentLabel.text="\(formatter.stringFromNumber(mathProblem.percentage*100)) percent"
        
        operand.text=formatter.stringFromNumber(mathProblem.operand)
        
        correctIndicator.text=""
        
    }
    
    
    
}

