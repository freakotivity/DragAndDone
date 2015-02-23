//
//  FoldersListTableViewCell.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-23.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class FoldersListTableViewCell: UITableViewCell {

    @IBOutlet weak var theTextLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var editButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editStuff(sender: AnyObject) {
        println("EDIT STUFF \(sender)")
    }
}
