//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by wangyu on 16/3/24.
//  Copyright © 2016年 wangyu. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodRating: RatingControl!
}
