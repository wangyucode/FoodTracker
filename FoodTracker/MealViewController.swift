//
//  MealViewController.swift
//  FoodTracker
//
//  Created by wangyu on 16/3/18.
//  Copyright © 2016年 wangyu. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
   
    @IBOutlet weak var textFieldFoodName: UITextField!
    @IBOutlet weak var imagePhoto: UIImageView!

    @IBOutlet weak var ratingControl: RatingControl!
    
    // MARK: Navigation
    @IBOutlet weak var btnSave: UIBarButtonItem!
    /*
     This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal:Meal?
    
    // MARK: Actions

    @IBAction func onTapImage(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        textFieldFoodName.resignFirstResponder()

        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let uiImagePicker = UIImagePickerController()

        // Only allow photos to be picked, not taken.
        uiImagePicker.sourceType = .PhotoLibrary

        // Make sure ViewController is notified when the user picks an image.
        uiImagePicker.delegate = self

        presentViewController(uiImagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: Navigation
    @IBAction func cancelClicked(sender:UIBarButtonItem){
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        if presentingViewController is UINavigationController{
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === btnSave{
            
            let name = textFieldFoodName.text ?? ""
            let image = imagePhoto.image
            let rating = ratingControl.rating
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(name: name, rating: rating, photo: image)
            
            
        }
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePhoto.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }


    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        btnSave.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidName()
        navigationItem.title = textFieldFoodName.text
    }

    func checkValidName(){
        // Disable the Save button if the text field is empty.
        let name = textFieldFoodName.text ?? ""
        btnSave.enabled = !name.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //Handle the text field’s user input through delegate callbacks.        
        textFieldFoodName.delegate = self
        
        // Set up views if editing an existing Meal.
        if let meal = meal{
            navigationItem.title = meal.name
            textFieldFoodName.text = meal.name
            imagePhoto.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidName()


    }


}

