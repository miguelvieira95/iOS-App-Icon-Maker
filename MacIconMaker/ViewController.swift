//
//  ViewController.swift
//  MacIconMaker
//
//  Created by Miguel Vieira on 14/12/2018.
//  Copyright © 2018 Miguel Vieira. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var statusLabel : NSTextField!
    @IBOutlet weak var ipadCheckButton: NSButton!
    @IBOutlet weak var appleWatchCheckButton: NSButton!
    @IBOutlet weak var iPhoneCheckButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.stringValue = "";
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func ChooseImage(sender : NSButton)
    {
        statusLabel.stringValue = "Waiting...";
        
        let dialog = ImageDialog;
        if (dialog.runModal() == NSApplication.ModalResponse.OK)
        {
            if let result = dialog.url
            {
                if let imageToResize = NSImage(contentsOf: result)
                {
                    if (imageToResize.size.width != imageToResize.size.height)
                    {
                        WarningAlert(withMessage: "The image aspect ratio will be changed!").runModal();
                    }
                    
                    let (resizedImages, imageNames, finalJson) = ImageResizer().ResizeImages(imageToResize: imageToResize, resizeForiPhone: iPhoneCheckButton!.state == .on, resizeForiPad: ipadCheckButton!.state == .on, resizeForWatch: appleWatchCheckButton!.state == .on);
                    
                    let dialog = SaveDialog;
                    if dialog.runModal() == NSApplication.ModalResponse.OK, let url = dialog.url
                    {
                        statusLabel.stringValue = "Processing...";
                        FileManagerHelper().SaveImages(urlToSaveTo: url, images: resizedImages, fileNames: imageNames, jsonString: finalJson, completion: { (processStatus) in
                            statusLabel.stringValue = processStatus;
                        })
                    }
                }
                else
                {
                    ErrorAlert(withMessage: "Could not get image from the specified directory.").runModal();
                }
            }
        }
    }
}

