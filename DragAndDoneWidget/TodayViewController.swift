//
//  TodayViewController.swift
//  DragAndDoneWidget
//
//  Created by Ricardo Gonzalez on 2015-02-14.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
//        self.preferredContentSize = CGSizeMake(0, 400)
//        for i in 0...40
//        {
//            let yPos:CGFloat = CGFloat(i) * 10
//            let label = UILabel(frame: CGRectMake(0, yPos, self.view.frame.size.width, 10))
//            label.text = "YEAH"
//            self.view.addSubview(label)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
