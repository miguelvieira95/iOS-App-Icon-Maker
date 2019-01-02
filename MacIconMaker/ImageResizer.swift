//
//  ImageResizer.swift
//  MacIconMaker
//
//  Created by Miguel Vieira on 14/12/2018.
//  Copyright © 2018 Miguel Vieira. All rights reserved.
//

import Cocoa

class ImageResizer
{
    private func Resize(image : NSImage?, size : CGSize) -> NSImage?
    {
        guard let imageToResize = image else { return nil }
        let newImageFrame = NSRect(x: 0, y: 0, width: size.width, height: size.height);
        guard let imageRepresentation = imageToResize.bestRepresentation(for: newImageFrame, context: nil, hints: nil) else { return nil }
        
        
        let resizedImage = NSImage(size: size, flipped: false, drawingHandler: { (_) -> Bool in
            return imageRepresentation.draw(in: newImageFrame);
        })
        
        return resizedImage;
    }
    
    func ResizeiOSImages(imageToResize : NSImage, resizeForiPhone : Bool, resizeForiPad : Bool) -> ([NSImage], [String], String)
    {
        var jsonString = "{ \n \"images\" : [";
        
        var resizedImages = [NSImage]()
        var names = [String]()
        
        for i in 0..<universalDimensions.count
        {
            guard let resizedImage = Resize(image: imageToResize, size: universalDimensions[i].dimensions) else { continue }
            resizedImages.append(resizedImage)
            names.append(universalDimensions[i].name)
            
            var scale = "1x";
            var dimensionInPoints = universalDimensions[i].dimensions.width;
            
            if (names[i].contains("2x"))
            {
                scale = "2x";
                dimensionInPoints/=2;
            }
            else if (names[i].contains("3x"))
            {
                scale = "3x";
                dimensionInPoints/=3;
            }
            
            let dimensionString = String(format: "%g", dimensionInPoints)
            
            jsonString.append("\n\t{ \n\t \"size\" : \"\(dimensionString)x\(dimensionString)\", \n\t \"idiom\" : \"iPhone\", \n\t \"filename\" : \"\(universalDimensions[i].name)\",\n\t \"scale\" : \"\(scale)\"\n\t},");
            
            jsonString.append("\n\t{ \n\t \"size\" : \"\(dimensionString)x\(dimensionString)\", \n\t \"idiom\" : \"iPad\",\n\t \"scale\" : \"\(scale)\"\n\t},");
        }
        
        if (resizeForiPhone)
        {
            for i in 0..<iphoneDimensions.count
            {
                guard let resizedImage = Resize(image: imageToResize, size: iphoneDimensions[i].dimensions) else { continue }
                resizedImages.append(resizedImage)
                names.append(iphoneDimensions[i].name)
                
                var scale = "1x";
                var dimensionInPoints = iphoneDimensions[i].dimensions.width;
                
                if (names[i].contains("2x"))
                {
                    scale = "2x";
                    dimensionInPoints/=2;
                }
                else if (names[i].contains("3x"))
                {
                    scale = "3x";
                    dimensionInPoints/=3;
                }
                
                let dimensionString = String(format: "%g", dimensionInPoints)

                jsonString.append("\n\t{ \n\t \"size\" : \"\(dimensionString)x\(dimensionString)\", \n\t \"idiom\" : \"iPhone\", \n\t \"filename\" : \"\(iphoneDimensions[i].name)\",\n\t \"scale\" : \"\(scale)\" \n\t},");
            }
        }
        
        if (resizeForiPad)
        {
            for i in 0..<iPadDimensions.count
            {
                guard let resizedImage = Resize(image: imageToResize, size: iPadDimensions[i].dimensions) else { continue }
                resizedImages.append(resizedImage)
                names.append(iPadDimensions[i].name)
                
                var scale = "1x";
                var dimensionInPoints = iPadDimensions[i].dimensions.width;
                
                if (names[i].contains("2x"))
                {
                    scale = "2x";
                    dimensionInPoints/=2;
                }
                else if (names[i].contains("3x"))
                {
                    scale = "3x";
                    dimensionInPoints/=3;
                }
                
                let dimensionString = String(format: "%g", dimensionInPoints)
                
                jsonString.append("\n\t{ \n\t \"size\" : \"\(dimensionString)x\(dimensionString)\", \n\t \"idiom\" : \"iPad\", \n\t \"filename\" : \"\(iPadDimensions[i].name)\",\n\t \"scale\" : \"\(scale)\" \n\t},");
            }
        }
        
        jsonString.removeLast(); //ultima virgula
        jsonString.append("\n],\n \"info\" : { \n\t\"version\" : 1,\n\t\"author\" : \"xcode\"\n  }\n}")
        
        return (resizedImages, names, jsonString);
    }
    
    func ResizeWatchImages(imageToResize : NSImage) -> ([NSImage], [String], String)
    {
        var jsonString = "{ \n \"images\" : [";
        
        var resizedImages = [NSImage]()
        var names = [String]()
        
        for i in 0..<watchDimensions.count
        {
            guard let resizedImage = Resize(image: imageToResize, size: watchDimensions[i].dimensions) else { continue }
            
            resizedImages.append(resizedImage)
            names.append(watchDimensions[i].name)
            
            let scale = names[i].contains("3x") ? "3x" : "2x";
            let dimensionInPoints = scale == "3x" ? watchDimensions[i].dimensions.width/3 : watchDimensions[i].dimensions.width/2;
            
            let dimensionString = String(format: "%g", dimensionInPoints)

            if let subtype = watchDimensions[i].subtype
            {
                jsonString.append("\n\t{ \n\t \"size\" : \"\(dimensionString)x\(dimensionString)\", \n\t \"idiom\" : \"watch  \", \n\t \"filename\" : \"\(watchDimensions[i].name)\",\n\t \"role\" : \"\(watchDimensions[i].role)\",\n\t \"subtype\" : \"\(subtype)\",\n\t \"scale\" : \"\(scale)\" \n\t},");
            }
            else
            {
                jsonString.append("\n\t{ \n\t \"size\" : \"\(dimensionString)x\(dimensionString)\", \n\t \"idiom\" : \"watch  \", \n\t \"filename\" : \"\(watchDimensions[i].name)\",\n\t \"role\" : \"\(watchDimensions[i].role)\",\n\t \"scale\" : \"\(scale)\" \n\t},");
            }
            
        }
        
        jsonString.removeLast(); //ultima virgula
        jsonString.append("\n],\n \"info\" : { \n\t\"version\" : 1,\n\t\"author\" : \"xcode\"\n  }\n}")
        
        return (resizedImages, names, jsonString);
    }
}
