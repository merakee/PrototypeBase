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
        self.view.backgroundColor = UIColor.appBlueColor
        // other set up
        let button = AppUIManager.sharedManager.getButtonWithTitle("Button", buttonColor: UIColor.redColor(), textColor: UIColor.whiteColor())
        self.view.addSubview(button)
        button.autoSetDimension(.Height, toSize: 60.0)
        button.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0,30.0,60.0,30.0), excludingEdge: .Top)
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
        print("Button Pressed....")
    }
}

