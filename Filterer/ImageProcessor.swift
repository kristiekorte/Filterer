//
//  ImageProcessor.swift
//  Filterer
//
//  Created by Kristie Korte on 2/24/16.
//  Copyright © 2016 UofT. All rights reserved.
//
import UIKit
import Foundation


struct FilterParameters {
    var filterName:String = ""
    var color:String = ""
    var factor:Int = 0
    var order:Int = 0
    init(filterNamex:String, colorx:String, factorx:Int, orderx:Int){
        filterName = filterNamex
        color = colorx
        factor = factorx
        order = orderx
    }
}


//Create 5 Predefined Filters - You can change the intensity of each filter by chaning its "factor"

var filter_incRed3x = FilterParameters(filterNamex: "IncRed3x", colorx: "red", factorx: 3, orderx: 1)        //Filter to increase red pixel 3x


var filter_incGreen3x = FilterParameters(filterNamex: "IncGreen3x", colorx: "green", factorx: 3, orderx: 2)      //Filter to increase green pixel 3x


var filter_incBlue3x = FilterParameters(filterNamex: "IncBlue3x", colorx: "blue", factorx: 3, orderx: 3)      //Filter to increase blue pixel 3x


var filter_incYellow3x = FilterParameters(filterNamex: "IncYellow3x", colorx: "yellow", factorx: 3, orderx: 4)  //Filter to increase yellow 3x


var filter_incPurple3x = FilterParameters(filterNamex: "IncPurple3x", colorx: "purple", factorx: 3, orderx: 5)   //Filter to increase purple 3x



var myRGBAImage:RGBAImage?

//average color of the pixels

var totalRed = 0
var totalGreen = 0
var totalBlue = 0

var count = 0
var avgRed = 0
var avgGreen = 0
var avgBlue = 0


public struct ImageProcessor {
    
    static public func filterImage(imageIn:UIImage, usingFilterName filterName:String) -> UIImage {
        
        let image = imageIn
        
        convertImagetoRGBAandCalculateAverages(image)
        
        //Switch on filterName
        switch filterName {
            
        case "incYellow3x":
            return ImageProcessor.filterImage(imageIn, filterArray:[filter_incYellow3x])
            
        case "incBlue3x":
            return ImageProcessor.filterImage(imageIn, filterArray: [filter_incBlue3x])
            
        case "incPurple3x":
            return ImageProcessor.filterImage(imageIn, filterArray:[filter_incPurple3x])
            
            
        case "incRed3x":
            return ImageProcessor.filterImage(imageIn, filterArray:[filter_incRed3x])
            
            
        case "incGreen3x":
            return ImageProcessor.filterImage(imageIn, filterArray:[filter_incGreen3x])
            
        default:
            break
            
            
        }
        return image
    }
    
    //Function to handle an artibtrary number of filters passed in as an array will increase color of pixels
    static func filterImage(imageIn:UIImage, filterArray:Array<FilterParameters>) -> UIImage
    {
        
        let image = imageIn
        let myRGBAImage = RGBAImage(image:image)!
        
        convertImagetoRGBAandCalculateAverages(image)
        
        
        for filter in filterArray {
            
            for y in 0..<myRGBAImage.height {
                for x in 0..<myRGBAImage.width {
                    let index = y * myRGBAImage.width + x
                    
                    var pixel = myRGBAImage.pixels[index]
                    switch filter.color {
                    case "red":
                        let redDiff = Int(pixel.red) - avgRed
                        if (redDiff > 0) {
                            pixel.red = UInt8(max(0, min(255, avgRed * filter.factor)))
                            
                        }
                        break
                        
                    case "green":
                        let greenDiff = Int(pixel.green) - avgGreen
                        if (greenDiff > 0) {
                            pixel.green = UInt8(max(0, min(255, avgGreen * filter.factor)))
                        }
                        break
                        
                    case "blue":
                        let blueDiff = Int(pixel.blue) - avgBlue
                        if (blueDiff > 0) {
                            pixel.blue = UInt8(max(0, min(255, avgBlue * filter.factor)))
                        }
                        break
                    case "yellow":
                        let greenDiff = Int(pixel.green) - avgGreen
                        if (greenDiff > 0) {
                            pixel.green = UInt8(max(0, min(255, avgGreen * filter.factor)))
                        }
                        let redDiff = Int(pixel.red) - avgRed
                        if (redDiff > 0) {
                            pixel.red = UInt8(max(0, min(255, avgRed * filter.factor)))
                        }

                        break
                        
                    case "purple":
                        let redDiff = Int(pixel.red) - avgRed
                        if (redDiff > 0) {
                            pixel.red = UInt8(max(0, min(255, avgRed * filter.factor)))
                        }
                        let blueDiff = Int(pixel.blue) - avgBlue
                        if (blueDiff > 0) {
                            pixel.blue = UInt8(max(0, min(255, avgBlue * filter.factor)))
                        }
                        break
                    default:
                        break
                    }
                    
                    myRGBAImage.pixels[index] = pixel
                }
            }
        }
        return myRGBAImage.toUIImage()!
    }
    static func convertImagetoRGBAandCalculateAverages(imageIn:UIImage) ->RGBAImage {
        
        //Convert the image into a RGBA image
        
        
        let myRGBAImage = RGBAImage(image: imageIn)!
        //Find the average color of the pixels
        
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        //Loop through adding up pixels and divide by number of pixels
        
        for y in 0..<myRGBAImage.height {
            for x in 0..<myRGBAImage.width {
                
                let index = y * myRGBAImage.width + x
                var pixel = myRGBAImage.pixels[index]
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        //Find average
        let count = myRGBAImage.width * myRGBAImage.height  //Find number of pixels
        avgRed = totalRed/count
        avgGreen = totalGreen/count
        avgBlue = totalBlue/count
        
        return myRGBAImage
        
    }
    

    
}