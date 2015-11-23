//
//  ViewController.swift
//  PrototypeBase
//
//  Created by Bijit Halder on 11/14/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout

class MainViewController: UIViewController {
    
    // MARK: - View Set up
    override func loadView() {
        super.loadView()
        setView()
        
    }
    
    func setView(){
        // hide or show nav bar
        self.navigationController?.navigationBar.hidden = true
        
        // back ground color
        self.view.backgroundColor = UIColor.whiteColor()//appBlueColor
        //AppUIManager.sharedManager.addColorGradientToView(self.view, colors: [UIColor.appBlueColor.CGColor,UIColor.appGrayColor.CGColor])
        // other set up
        let button = AppUIManager.sharedManager.getCircularButtonWithTitle("Button", buttonColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        self.view.addSubview(button)
        button.autoSetDimension(.Height, toSize: 80.0)
        button.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Width, ofView:button)
        //button.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        button.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        button.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60.0)
        
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Button Actions
    func buttonPressed(sender: UIButton!){
        // print(CommonUtils.sharedInstance.getDocumentRootDirectory())
        //print(CommonUtils.sharedInstance.getResourceRootDirectory())
        // play sound
        //AppAudioManager.sharedManager.playSoundFromFile("railroad_crossing_bell", ofType: "wav")
        //let aplayer = AppAudioManager.sharedManager.playSoundFromFile("pay", ofType: "mp3")
        let aplayer = AppAudioManager.sharedManager.playSoundFromFile("railroad_crossing_bell", ofType: "wav")
        aplayer!.play()
    }
}

