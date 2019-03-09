//
//  FileManagerHelper.swift
//  MacIconMaker
//
//  Created by Miguel Vieira on 14/12/2018.
//  Copyright © 2018 Miguel Vieira. All rights reserved.
//

import Cocoa

class FileManagerHelper
{
    private func SaveData(data : Data?, toPath path: String, withName fileName : String, fileExtension : String)
    {
        guard let unwrappedData = data else { return }
        do
        {
            let bitmapRepresentation = NSBitmapImageRep(data: unwrappedData);
            let dataToWrite = bitmapRepresentation?.representation(using: .png, properties: [:]);
            
            let completePath = URL(fileURLWithPath: "\(path)/\(fileName).\(fileExtension)")
            
            try dataToWrite?.write(to: completePath, options: [])
        }
        catch let error
        {
            ErrorAlert(withMessage: error.localizedDescription).runModal();
        }
    }
    
    func SaveImages(urlToSaveTo : URL, images : [NSImage], fileNames : [String], jsonString : String, watchImages : [NSImage]?, watchFileNames : [String]?, watchJsonString : String?, completion : ((String) -> ()))
    {
        let userChosenPath = urlToSaveTo.absoluteString.replacingOccurrences(of: "file://", with: "");
        var pathToSaveTo = userChosenPath;
        let watchFolderPath = "\(pathToSaveTo)/WatchIcons";
        let iOSFolderPath = "\(pathToSaveTo)/AppIcon";
        var foundValidDirectory = false;
        var count : Int = 0;
        
        while (!foundValidDirectory && count<100)
        {
            pathToSaveTo = count == 0 ? userChosenPath : "\(userChosenPath)\(count)"
            
            foundValidDirectory = !FileManager().fileExists(atPath: pathToSaveTo);
            count+=1;
        }
        
        do
        {
            try FileManager().createDirectory(at: URL(fileURLWithPath: pathToSaveTo), withIntermediateDirectories: true, attributes: nil);
            
            try FileManager().createDirectory(at: URL(fileURLWithPath: iOSFolderPath), withIntermediateDirectories: true, attributes: nil);
        }
        catch let error
        {
            ErrorAlert(withMessage: error.localizedDescription).runModal();
            completion("Failed. Could not create directory.");
            return;
        }
        
        for i in 0..<images.count
        {
            FileManagerHelper().SaveData(data: images[i].tiffRepresentation, toPath: iOSFolderPath, withName: fileNames[i], fileExtension: "png");
        }
        
        if (!SaveContentsJson(withString: jsonString, andPath: iOSFolderPath))
        {
            completion("Could not create iOS Contents.json file.")
        }
        
        if let unwrappedWatchImages = watchImages, let unwrappedWatchFileNames = watchFileNames, let unwrappedWatchJsonString = watchJsonString
        {
            do
            {
                try FileManager().createDirectory(at: URL(fileURLWithPath: watchFolderPath), withIntermediateDirectories: true, attributes: nil);
            }
            catch let error
            {
                ErrorAlert(withMessage: error.localizedDescription).runModal();
                completion("Failed. Could not create Watch directory.");
                return;
            }
            
            for i in 0..<unwrappedWatchImages.count
            {
                FileManagerHelper().SaveData(data: unwrappedWatchImages[i].tiffRepresentation, toPath: watchFolderPath, withName: unwrappedWatchFileNames[i], fileExtension: "png");
            }
            
            if (!SaveContentsJson(withString: unwrappedWatchJsonString, andPath: watchFolderPath))
            {
                completion("Could not create Watch Contents.json file.")
            }
        }
        
        completion("Done.");
    }
    
    private func SaveContentsJson(withString contentsString : String, andPath path : String) -> Bool
    {
        let file = "Contents.json"
        let fileURL = URL(fileURLWithPath: path).appendingPathComponent(file)
        
        do
        {
            try contentsString.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch let error
        {
            print(error.localizedDescription);
            return false;
        }
        
        return true;
    }
}

