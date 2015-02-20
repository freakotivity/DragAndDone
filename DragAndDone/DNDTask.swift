//
//  DNDTask.swift
//  DNDEditor
//
//  Created by Ricardo Gonzalez on 2015-02-03.
//  Copyright (c) 2015 FreakoSoft. All rights reserved.
//

import UIKit

class DNDTask: NSObject {
    var name:String?
    var imageName:String?
//    var doneImageName:String?
    var done = false
    var taskID:String?
    
    func description() -> String
    {
        return "TASK NAMED:\(name) IMAGENAME:\(imageName) DONE: \(done) ID: \(taskID)"
    }
}
