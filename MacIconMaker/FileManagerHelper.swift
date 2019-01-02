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
    
    func SaveImages(urlToSaveTo : URL, images : [NSImage], fileNames : [String], jsonString : String, completion : ((String) -> ()))
    {
            let userChosenPath = urlToSaveTo.absoluteString.replacingOccurrences(of: "file://", with: "");
            let originalPath = "\(userChosenPath)ResizedIcons";
            var pathToSaveTo = originalPath;
            var foundValidDirectory = false;
            var count : Int = 0;
            
            while (!foundValidDirectory && count<100)
            {
                pathToSaveTo = count == 0 ? originalPath : "\(originalPath)\(count)"
                
                foundValidDirectory = !FileManager().fileExists(atPath: pathToSaveTo);
                count+=1;
            }
            
            do
            {
                try FileManager().createDirectory(at: URL(fileURLWithPath: "\(pathToSaveTo)"), withIntermediateDirectories: true, attributes: nil);
            }
            catch let error
            {
                ErrorAlert(withMessage: error.localizedDescription).runModal();
                completion("Failed. Could not create directory.");
                return;
            }
            
            for i in 0..<images.count
            {
                FileManagerHelper().SaveData(data: images[i].tiffRepresentation, toPath: pathToSaveTo, withName: fileNames[i], fileExtension: "png");
            }
            
            let file = "Contents.json"
            let fileURL = URL(fileURLWithPath: pathToSaveTo).appendingPathComponent(file)
            
            do
            {
                try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch let error
            {
                print(error.localizedDescription);
                completion("Failed. Could not \"Contents.json\" file.");
                return;
            }
        
            completion("Done.");

    }
}

