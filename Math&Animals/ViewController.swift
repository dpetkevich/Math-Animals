//
//  ViewController.swift
//  stressMath
//
//  Created by Daniel Petkevich on 9/4/14.
//  Copyright (c) 2014 Daniel Petkevich. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {
    
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
        var image1 = UIImage.animatedImageWithAnimatedGIFData(NSData(contentsOfURL:NSBundle.mainBundle().URLForResource(String(arc4random_uniform(34)+1), withExtension: ".gif")!))
        
        var stringWithoutCommas = (submission.text).stringByReplacingOccurrencesOfString(",", withString:"")
        
        
        if mathProblem.isCorrect(stringWithoutCommas.toInt()!) == true
        {
            submission.resignFirstResponder()
            submitButton.hidden=true
            correctIndicator.text="Good."
            rewardImage.image=image1
            
            
            NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("refreshUI"), userInfo: nil, repeats: false)
            
        }
        else{
            println(submission.text)
            submission.text=""
            correctIndicator.text="Wrong. Get it right this time."
            
        }
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        submission.delegate = self
        
        
        
        refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: UITextFieldDelegate
    
     func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {


        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        
        var initialString = textField.text
        
        var combinedString = (initialString as NSString).stringByReplacingCharactersInRange(range, withString:string)
        var stringWithoutCommas = combinedString.stringByReplacingOccurrencesOfString(",", withString:"")


        
        if let formattedNumber = stringWithoutCommas.toInt() {
            var displayNumber = formatter.stringFromNumber(formattedNumber)
            textField.text=displayNumber

        }
        else{
            return true
        }
//

        return false
        
        
    }
    
    func goToNextCard(){
        UIView.transitionFromView(test, toView: test, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft |
            UIViewAnimationOptions.ShowHideTransitionViews,
            completion: nil)
        
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
        submitButton.hidden=false
        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
        formatter.maximumFractionDigits = 0
        
        
        percentLabel.text="\(formatter.stringFromNumber(mathProblem.percentage*100)!) percent"
        
        operand.text=formatter.stringFromNumber(mathProblem.operand)
        
        correctIndicator.text=""
        
        submission.becomeFirstResponder()

        
    }
    
    
    
}

