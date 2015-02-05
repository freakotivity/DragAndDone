//
//  NewTaskViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-05.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

protocol NewTaskDelegate {
    func addTask(task: DNDTask)
}

class NewTaskViewController: UIViewController {
    var delegate:NewTaskDelegate?
    
    let doStuff = ["Mock", "Brush", "Wash", "Sing", "Play", "Drink", "Eat", "Go", "Dance"]
    let stuff = ["Teeth", "Juice", "Disco", "Fubar", "Fork", "Salsa", "Rick Astley", "Freak", "Snow"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func done() {
        let nuTask = DNDTask()
        nuTask.name = self.doStuff[Int(arc4random_uniform(UInt32(self.doStuff.count)))] + " " + self.stuff[Int(arc4random_uniform(UInt32(self.stuff.count)))]
        nuTask.imageName = "yeah"
        self.delegate?.addTask(nuTask)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
