//
//  ELEventCell.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EventCell: CollectionViewCell {

    //MARK: Outlets
    @IBOutlet weak var img_event:       UIImageView!
    @IBOutlet weak var lb_event:        UILabel!
    @IBOutlet weak var event_width:     NSLayoutConstraint!
    @IBOutlet weak var event_height:    NSLayoutConstraint!
    @IBOutlet weak var event_right:     NSLayoutConstraint!
    @IBOutlet weak var img_user:        UIImageView!
    @IBOutlet weak var v_separator:     UIView!
    @IBOutlet weak var sep_height:      NSLayoutConstraint!
    @IBOutlet weak var lb_user:         UILabel!
    @IBOutlet weak var user_width:      NSLayoutConstraint!
    @IBOutlet weak var user_height:     NSLayoutConstraint!
    @IBOutlet weak var lb_price:        UILabel!
    @IBOutlet var v_stars:              [StarView]!
    @IBOutlet weak var lb_score:        UILabel!
    @IBOutlet weak var score_height:    NSLayoutConstraint!
    @IBOutlet weak var score_width:     NSLayoutConstraint!
    
    //MARK: Datas
    static let currencyFormatter = NumberFormatter()
    
    var event:EventModel?
    
    //MARK: Methods
    class func size(forEvent event:EventModel, referenceWidth:CGFloat) -> CGSize {
        let img_width = referenceWidth - 16.0
        var height = 8.0 + img_width * 9.0 / 16.0
        height += 8.0 + 30.0 + 8.0 + 0.5 + 8.0 //cover bottom + user img height + user img bottom + sep + bottom margin
        let firstname = event.user.firstname
        let size = firstname.textSize(withFont: UIFont.systemFont(ofSize: 14.0), maximumWidth: referenceWidth - 8.0 - 8.0 - 30.0 - 8.0)
        height += size.height
        height += 4.0
        if event.price > 0 {
            height += 20.0 + 4.0
        }
        return CGSize(width: referenceWidth, height: height)
    }
    
    func display(event:EventModel) {
        self.event = event
        
        Alamofire.request(event.cover.path).responseImage { [weak self] response in
            guard let strongSelf = self else { return }
            if let event = strongSelf.event, event.cover.path != response.request?.url?.absoluteString {
                return
            }
            if let image = response.result.value {
                strongSelf.img_event.backgroundColor = .clear
                strongSelf.img_event.image = image
            }
        }
        
        Alamofire.request(event.user.avatar.path).responseImage { [weak self] response in
            guard let strongSelf = self else { return }
            if let event = strongSelf.event, event.user.avatar.path != response.request?.url?.absoluteString {
                return
            }
            if let image = response.result.value {
                strongSelf.img_user.backgroundColor = .clear
                strongSelf.img_user.image = image.af_imageRoundedIntoCircle()
            }
        }
        
        lb_event.text = event.title
        
        let firstname = event.user.firstname
        lb_user.text = firstname
        let size = firstname.textSize(withFont: lb_user.font, maximumWidth: frame.size.width - 8.0 - 8.0 - img_user.frame.size.width - 8.0)
        user_width.constant = size.width
        user_height.constant = size.height
        
        EventCell.currencyFormatter.usesGroupingSeparator = true
        EventCell.currencyFormatter.numberStyle = .currency
        EventCell.currencyFormatter.locale = Locale.current
        EventCell.currencyFormatter.currencyCode = event.currency.iso_3
        EventCell.currencyFormatter.currencySymbol = event.currency.symbol
        let priceString = EventCell.currencyFormatter.string(from: NSNumber(value: event.price))
        lb_price.text = priceString
        for i in 0..<Int(round(event.user.user_rating_score)) {
            v_stars[i].fillColor = UIColor(red: 188.0/255.0, green: 188.0/255.0, blue: 188.0/255.0, alpha: 1.0)
            v_stars[i].setNeedsDisplay()
        }
        let score = "(\(event.user.user_rating_score))"
        let scoreSize = score.textSize(withFont: lb_score.font)
        score_width.constant = scoreSize.width
        score_height.constant = scoreSize.height
        lb_score.text = score
        
        event_height.constant = img_user.frame.size.height
        event_width.priority = UILayoutPriorityDefaultLow
        event_right.priority = 999
    }
    
    //MARK: Style
    override func setupStyle() {
        backgroundColor = .clear
        img_user.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        img_event.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        lb_event.font = UIFont.boldSystemFont(ofSize: 14.0)
        lb_event.textColor = UIColor(red: 188.0/255.0, green: 188.0/255.0, blue: 188.0/255.0, alpha: 1.0)
        lb_event.text = ""
        lb_user.font = UIFont.systemFont(ofSize: 14.0)
        lb_user.textColor = .black
        lb_user.text = ""
        
        lb_price.font = UIFont.boldSystemFont(ofSize: 14.0)
        lb_price.textColor = .black
        lb_price.text = ""

        lb_score.font = UIFont.boldSystemFont(ofSize: 14.0)
        lb_score.textColor = UIColor(red: 188.0/255.0, green: 188.0/255.0, blue: 188.0/255.0, alpha: 1.0)
        lb_score.text = ""
        
        v_separator.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        sep_height.constant = 0.5
        img_user.layer.cornerRadius = img_user.frame.size.height / 2.0
    }
    
    override func prepareForReuse() {
        lb_event.text = ""
        lb_user.text = ""
        lb_price.text = ""
        lb_score.text = "(0)"
        img_event.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        img_user.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        img_event.image = nil
        img_user.image = nil
        event = nil
        for v_star in v_stars {
            v_star.fillColor = .clear
            v_star.setNeedsDisplay()
        }
    }
}

//MARK: PlaceHolder
extension EventCell {
    class func size(referenceWidth:CGFloat) -> CGSize {
        let img_width = referenceWidth - 16.0
        var height = 8.0 + img_width * 9.0 / 16.0
        height += 8.0 + 30.0 + 8.0 + 0.5 + 8.0 //cover bottom + user img height + user img bottom + sep + bottom margin
        height += 21.0 // user
        height += 4.0
        return CGSize(width: referenceWidth, height: height)
    }
    
    func displayPlaceholder() {
        lb_event.text = ""
        lb_user.text = ""
        lb_price.text = ""
        lb_score.text = ""
        user_width.constant = 60.0
        user_height.constant = 12.0
        img_event.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        img_user.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        lb_user.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        lb_event.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        img_event.image = nil
        img_user.image = nil
        event = nil
        for v_star in v_stars {
            v_star.fillColor = .clear
            v_star.setNeedsDisplay()
        }
        event_height.constant = 15.0
        event_width.priority = 999
        event_right.priority = UILayoutPriorityDefaultLow
    }
}
