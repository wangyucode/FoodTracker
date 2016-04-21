//
//  RatingControl.swift
//  FoodTracker
//
//  Created by wangyu on 16/3/24.
//  Copyright © 2016年 wangyu. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: Properties
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    
    let spacing = 5
    let starCount = 5


    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let emptyImage = UIImage(named: "emptyStar")
        let fillImage = UIImage(named: "fillStar")

        for _ in 0 ..< starCount {

            let button = UIButton()
            button.setImage(emptyImage, forState: .Normal)
            button.setImage(fillImage, forState: .Selected)
            button.setImage(fillImage, forState: [.Highlighted,.Selected])
            
            button.adjustsImageWhenHighlighted=false
            
            button.addTarget(self, action: #selector(buttonTap), forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }

    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.height)
        let width = buttonSize*starCount+spacing*(starCount-1)
        return CGSize(width: width, height: buttonSize)
    }
    
    // Offset each button's origin by the length of the button plus spacing.
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for(index,button) in ratingButtons.enumerate(){
            buttonFrame.origin.x = CGFloat(index*(buttonSize+spacing))
            button.frame=buttonFrame
        }

        updateButtonSelectionStates()
    }


    // MARK: Button Action
    func buttonTap(button: UIButton) {
        rating = ratingButtons.indexOf(button)!+1
        
        updateButtonSelectionStates()
    }
    
    
    func updateButtonSelectionStates() {
        for(index,botton)in ratingButtons.enumerate(){
            // If the index of a button is less than the rating, that button should be selected.
            botton.selected = index<rating
        }
    }


}
