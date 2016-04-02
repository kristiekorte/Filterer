//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage? //Results
    var currentImage: UIImage?  //Image being processed
    
    var filterFactor: Int? //Level of filtering 0-5
    
    @IBOutlet var imageView: UIImageView!  //View on Screen
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var thirdMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
   //Buttons
    @IBOutlet var filterButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var newPhotoButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    
    //Origianl Label
    
    @IBOutlet weak var originalLabel: UILabel!
    
    //Individual Filter Buttons
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    
    
    @IBOutlet weak var filterSlider: UISlider!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        //init default image
        imageView.image = UIImage(named: "scenery") //Default image
        currentImage = UIImage(named: "scenery")
        
        //Compare & Edit button should be disabled until user touches Filter
        compareButton.hidden = true
        editButton.hidden = true
        
        //Original Label will be hidden unless compare is in use
        originalLabel.hidden = true
        
        //Set Tint Color on Individual Filter Buttons
        let buttonImage = UIImage(named: "icon-MenuIcon")
        
        redButton.setImage(buttonImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
        redButton.tintColor = UIColor.redColor()
        
        greenButton.setImage(buttonImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
        greenButton.tintColor = UIColor.greenColor()
        
        blueButton.setImage(buttonImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
        blueButton.tintColor = UIColor.blueColor()
        
        yellowButton.setImage(buttonImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
        yellowButton.tintColor = UIColor.yellowColor()
        
        purpleButton.setImage(buttonImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
        purpleButton.tintColor = UIColor.purpleColor()
        
        filterFactor = 3  //default
        
        
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        filterButton.hidden = true
        hideSecondaryMenu()
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
       // presentViewController(activityController, animated: true, completion: nil)
        presentViewController(activityController, animated: true, completion: { action in
            self.filterButton.hidden = false
        })

    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        filterButton.hidden = true
        hideSecondaryMenu()
        
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
       // actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            self.filterButton.hidden = false
        }))
    
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
        

    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            currentImage = image

            //TODO - scale image to work with png only
//            let data:NSData = UIImageJPEGRepresentation(image, 0.2)!
//            currentImage = UIImage(data: data)
//            currentImage = compressForApp(image, scale: 0.2)
//           let pngData = UIImagePNGRepresentation(image)  //TRY PNG
//            currentImage = UIImage(data: pngData!)
            
        }
        print("User selected a new image")
        filterButton.hidden = false
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        filterButton.hidden = false
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {  //Displays or hides secondary menu
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
            //hide Compare button and "original label"
            compareButton.hidden = true
            originalLabel.hidden = true
            imageView.image = currentImage
            editButton.hidden = true
            newPhotoButton.hidden = false
            shareButton.hidden = false
        } else {
            showSecondaryMenu()
            sender.selected = true
            currentImage = imageView.image
            editButton.hidden = false
            newPhotoButton.hidden = true 
            shareButton.hidden = true
        }
        filteredImage = nil

    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    //Filter Buttons
    
    @IBAction func doRedFilter(sender: UIButton) {
        compareButton.hidden = false
        originalLabel.hidden = true
        print ("touched Red Filter" )
        filteredImage = doRed(currentImage!)  //Filterd Picture
        doCrossFade()  //Display Filitered Image
 
    }

    @IBAction func doGreenFilter(sender: UIButton) {
        compareButton.hidden = false
        originalLabel.hidden = true
        print ("touched Green Filter" )
        filteredImage = doGreen(currentImage!)  //Filterd Picture
        doCrossFade()  //Display Filitered Image
    }
    
    @IBAction func doBlueFilter(sender: UIButton) {
        compareButton.hidden = false
        originalLabel.hidden = true
        print ("touched Blue Filter")
        filteredImage = doBlue(currentImage!)  //Filterd Picture
        doCrossFade()  //Display Filitered Image
    }
    
    @IBAction func doYellowFilter(sender: UIButton) {
        compareButton.hidden = false
        originalLabel.hidden = true
        print("touched Yellow Filter")
        filteredImage = doYellow(currentImage!)  //Filterd Picture
        doCrossFade()
    }
    
    @IBAction func doPurpleFilter(sender: UIButton) {
        compareButton.hidden = false
        originalLabel.hidden = true
        print("touched Purple Button")
        filteredImage = doPurple(currentImage!)
        doCrossFade()  //Display Filitered Image
    }
    
    // Filter Functions
    
    func doRed(image:UIImage)-> UIImage {
        print("Processing image in Red Filter in doRed()")
        filter_incRed3x.factor = filterFactor!
        return ImageProcessor.filterImage(image, usingFilterName: "incRed3x")
        
    }
    func doGreen(image:UIImage)-> UIImage {
        print("Processing image in Green Filter in doGreen()")
        filter_incGreen3x.factor = filterFactor!
        return ImageProcessor.filterImage(image, usingFilterName: "incGreen3x")
    }
    func doBlue(image:UIImage)-> UIImage {
        print("Processing image in Blue Filter in doBlue()")
        filter_incBlue3x.factor = filterFactor!
        return ImageProcessor.filterImage(image, usingFilterName: "incBlue3x")
    }
    func doYellow(image:UIImage)-> UIImage {
        print("Processing image in Yellow Filter in doYellow()")
        filter_incYellow3x.factor = filterFactor!
        return ImageProcessor.filterImage(image, usingFilterName: "incYellow3x")
    }
    func doPurple(image:UIImage)-> UIImage {
        print("Processing image in Purple Filter in doPurple()")
        filter_incPurple3x.factor = filterFactor!
        return ImageProcessor.filterImage(image, usingFilterName: "incPurple3x")
    }
    //Edit Button
    
    @IBAction func onEdit(sender: UIButton) {
        print("User Pressed Edit Button")
        if (sender.selected) {
            hideThirdMenu()
            filterButton.hidden = false
            sender.selected = false
            compareButton.hidden = true
            originalLabel.hidden = true
            imageView.image = currentImage
          
        } else {
            showThirdMenu()
            filterButton.hidden = true
            sender.selected = true
            compareButton.hidden = true
            imageView.image = currentImage
 
        }
        filteredImage = nil
        editButton.hidden = false
    }
    
    func showThirdMenu() {
        hideSecondaryMenu()
        view.addSubview(thirdMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.thirdMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.thirdMenu.alpha = 1.0
        }

    }
    
    func hideThirdMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.thirdMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.thirdMenu.removeFromSuperview()
                }
        }
        showSecondaryMenu()
    }
    
    //Compare Button
    
    //Compare button should switch between filtered and current
    @IBAction func doCompare(sender: UIButton) {
        print("User Pressed Compare Button")
        if imageView.image == currentImage {
            doCrossFade()
            //imageView.image = filteredImage
            originalLabel.hidden = true
        }
        else{
            doCrossFade2()
            //imageView.image = currentImage
            originalLabel.hidden = false
        }
    }
    
    //Touch Events
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //This should only work if user has done a filter (e.g compare button is on
        if compareButton.hidden == true {
            return
        }
        print("User touched screen")
        if imageView.image == currentImage {
            //imageView.image = filteredImage
            doCrossFade()
            originalLabel.hidden = true
        }
        else{
            //imageView.image = currentImage
            doCrossFade2()
            originalLabel.hidden = false
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //This should only work if user has done a filter (e.g compare button is on
        if compareButton.hidden == true {
            return
        }
        print("User stopped touching screen")
        if imageView.image == currentImage {
            //imageView.image = filteredImage
            doCrossFade()
            originalLabel.hidden = true
        }
        else{
            //imageView.image = currentImage
            doCrossFade2()
            originalLabel.hidden = false
            
            
        }
        
    }
    func doCrossFade() {
        //CrossFade
        let crossFade:CABasicAnimation  = CABasicAnimation(keyPath:"contents")
        crossFade.duration = 0.3
        crossFade.fromValue = currentImage?.CGImage
        crossFade.toValue = filteredImage?.CGImage
        self.imageView.layer.addAnimation(crossFade, forKey: "animageContents")
        imageView.image = filteredImage
    }
    func doCrossFade2() {
        //CrossFade
        let crossFade:CABasicAnimation  = CABasicAnimation(keyPath:"contents")
        crossFade.duration = 0.3
        crossFade.fromValue = filteredImage?.CGImage
        crossFade.toValue = currentImage?.CGImage
        self.imageView.layer.addAnimation(crossFade, forKey: "animageContents")
        imageView.image = currentImage
    }
    
    func compressForApp(original:UIImage, scale:CGFloat) -> UIImage { //TODO
        // Calculate new size given scale factor.
        
        let originalSize = original.size
        let newSize:CGSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale)
        
        // Scale the original image to match the new size.
        UIGraphicsBeginImageContext(newSize)
        original.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return compressedImage
        
    }
    //Slider to adjust filter strength
    
    @IBAction func doSlider(sender: UISlider) {
        
        print ("User adjusted slider")
        let slider:UISlider = sender
        let value = Int(slider.value)
        filterFactor  = value
         print ("User adjusted slider to ", value)
        
        
    }

}

