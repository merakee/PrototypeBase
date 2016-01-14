//
//  SlideViewController.swift
//  PrototypeBase
//
//  Created by Bijit on 12/14/15.
//  Copyright © 2015 Bijit Halder. All rights reserved.
//

import UIKit
import PureLayout

class SlideViewController: UIViewController {
    var slideNumber = 0
    var slideImage: UIImageView!
    
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
        // slide image
        self.slideImage = UIImageView()
        self.view.addSubview(self.slideImage)
        self.slideImage.autoPinEdgesToSuperviewEdges()
        
        //let button = AppUIManager.sharedManager.getCircularButtonWithTitle("Start Speech", buttonColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        let button = AppUIManager.sharedManager.getClearButton()
        self.view.addSubview(button)
        button.autoPinEdgesToSuperviewEdges()
        //        button.autoSetDimension(.Height, toSize: 80.0)
        //        button.autoSetDimension(.Width, toSize: 300.0)
        //        //button.autoMatchDimension(ALDimension.Height, toDimension: ALDimension.Width, ofView:button)
        //        //button.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
        //        button.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        //        button.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60.0)
        
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Button Actions
    func buttonPressed(sender: UIButton!){
        // increase the slide number and set image
        slideNumber += 1
        updateView()
    }
    
    func updateView(){
        if let simage = self.getSildeImageForIndex(&self.slideNumber) {
             self.slideImage.image = simage
        }
    }
    
    func getSildeImageForIndex(inout index:Int) -> UIImage? {
        let slides = ["MapBuddy_Demo_view1.png",
            "MapBuddy_Demo_view2.png",
            "MapBuddy_Demo_view3.png",
            "MapBuddy_Demo_view4.png",
            "MapBuddy_Demo_view5.png",
            "MapBuddy_Demo_view6.png",
            "MapBuddy_Demo_view7.png",
            "MapBuddy_Demo_view4.png",
            "MapBuddy_Demo_view8.png"]
        
        if index >= slides.count {
            index = 0
        }
        
        return UIImage(named: slides[index])
    }
}
