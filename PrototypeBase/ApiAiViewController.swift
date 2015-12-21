//
//  ApiAiViewController.swift
//  PrototypeBase
//
//  Created by Bijit on 12/18/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout
import ApiAI

class ApiAiViewController: UIViewController {
    let apiAiManager = ApiAiManager.sharedManager
    
    // MARK: - View Set up
//    override func loadView() {
//        super.loadView()
//        //setView()
//    }
    
    func setView(){
        // hide or show nav bar
        self.navigationController?.navigationBar.hidden = true
        
        // back ground color
        self.view.backgroundColor = UIColor.whiteColor()//appBlueColor
        //AppUIManager.sharedManager.addColorGradientToView(self.view, colors: [UIColor.appBlueColor.CGColor,UIColor.appGrayColor.CGColor])
        // other set up
        //let button = AppUIManager.sharedManager.getCircularButtonWithTitle("Start Speech", buttonColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        // let button = AppUIManager.sharedManager.getButtonWithTitle("Start Speech", buttonColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        
       //let button = AppUIManager.sharedManager.getButtonWithTitle("Start Speech", buttonColor: UIColor.redColor(), textColor: UIColor.whiteColor()) //AIVoiceRequestButton()
        
     //   print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
    
       let button = AIVoiceRequestButton(frame: CGRectMake(100, 100, 100, 100))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //voiceRequestButton?.color = UIColor.appBlueColor
//        
//        button.successCallback = {(AnyObject response) -> Void in
//            self.processResult(response)
//        }
//        
//        button.failureCallback = {(NSError error) -> Void in
//            self.processError(error)
//        }
//        
        self.view.addSubview(button)
        
        print(NSURL(string:__FILE__)?.lastPathComponent!,":",__FUNCTION__,"Line:",__LINE__,"Col:",__COLUMN__)
        
        
        let views = ["button": button]
        var allConstraints = [NSLayoutConstraint]()
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-200-[button(70)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-200-[button(70)]",
            options: [],
            metrics: nil,
            views: views)
        

        NSLayoutConstraint.activateConstraints(allConstraints)
        
       // button.autoSetDimension(.Height, toSize: 100.0)
        //button.autoSetDimension(.Width, toSize: 100.0)
        //button.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Width, ofView:button)
        //button.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        //button.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
       //button.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60.0)
        
        //button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Button Actions
    //    func buttonPressed(sender: UIButton!){
    //        // print(CommonUtils.sharedInstance.getDocumentRootDirectory())
    //        //print(CommonUtils.sharedInstance.getResourceRootDirectory())
    //        // play sound
    //        //AppAudioManager.sharedManager.playSoundFromFile("railroad_crossing_bell", ofType: "wav")
    //        //let aplayer = AppAudioManager.sharedManager.playSoundFromFile("pay", ofType: "mp3")
    //        let aplayer = AppAudioManager.sharedManager.playSoundFromFile("railroad_crossing_bell", ofType: "wav")
    //        aplayer!.play()
    //    }
    
    // MARK: AIVoiceRequestButton call back methods
    func processResult(response: AnyObject) {
        print(response)
    }
    
    func processError(error: NSError){
        
    }
    
}
