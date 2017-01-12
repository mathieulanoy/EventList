//
//  ELEventHeaderView.swift
//  EventList
//
//  Created by Mathieu LANOY on 12/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class ELEventHeaderView: ELCollectionReusableView {

    @IBOutlet weak var lb_title:        UILabel!
    
    @IBOutlet weak var title_height:    NSLayoutConstraint!
    @IBOutlet weak var title_width:     NSLayoutConstraint!
    @IBOutlet weak var title_center:    NSLayoutConstraint!
    
    @IBOutlet weak var title_right: NSLayoutConstraint!
    @IBOutlet weak var title_top: NSLayoutConstraint!
    @IBOutlet weak var title_bottom: NSLayoutConstraint!
    
    @IBOutlet var seps_height: [NSLayoutConstraint]!
    
    override func setupStyle() {
        backgroundColor = .white
        lb_title.font = UIFont.boldSystemFont(ofSize: 14.0)
        lb_title.textColor = UIColor(red: 78.0/255.0, green: 78.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        for constraint in seps_height {
            constraint.constant = 0.5
        }
    }
    
    class func size(referenceWidth:CGFloat) -> CGSize {
        return CGSize(width: referenceWidth, height: 30.0)
    }
    
    func display(title:String){
        title_right.priority = 999
        title_top.priority = 999
        title_bottom.priority = 999
        title_width.priority = UILayoutPriorityDefaultLow
        title_height.priority = UILayoutPriorityDefaultLow
        title_center.priority = UILayoutPriorityDefaultLow
        lb_title.text = title
    }
}

extension ELEventHeaderView {
    func displayPlaceHolder() {
        title_width.priority = 999
        title_height.priority = 999
        title_center.priority = 999
        title_right.priority = UILayoutPriorityDefaultLow
        title_top.priority = UILayoutPriorityDefaultLow
        title_bottom.priority = UILayoutPriorityDefaultLow
        lb_title.text = ""
        lb_title.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    }
}
