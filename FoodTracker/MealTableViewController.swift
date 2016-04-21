//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by wangyu on 16/3/25.
//  Copyright © 2016年 wangyu. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    // MARK: Properties
    var meals = [Meal]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()

        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            // Load the sample data.
            loadSampleMeals()
        }
    }


    func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Meal(name: "番茄芝士沙拉", rating: 4, photo: photo1)!

        let photo2 = UIImage(named: "meal2")!
        let meal2 = Meal(name: "土豆烧鸡", rating: 3, photo: photo2)!

        let photo3 = UIImage(named: "meal3")!
        let meal3 = Meal(name: "肉丸意面", rating: 5, photo: photo3)!


        meals += [meal1, meal2, meal3]

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealTableViewCell", forIndexPath: indexPath) as! MealTableViewCell

        let meal = meals[indexPath.row]

        cell.foodImage.image = meal.photo
        cell.foodLabel.text = meal.name
        cell.foodRating.rating = meal.rating

        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            // Save the meals.
            saveMeals()

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view

        }
    }

    // Override to support conditional editing of the table view.


    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {


        if let sourceViewController = sender.sourceViewController as?
                MealViewController, meal = sourceViewController.meal {

            if let selectedPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedPath], withRowAnimation: .None)

            } else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }

            // Save the meals.
            saveMeals()
        }

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }

        } else if segue.identifier == "AddItem" {
            print("add new meal")
        }
    }


    // MARK: NSCoding
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("meals save failed")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }


}
