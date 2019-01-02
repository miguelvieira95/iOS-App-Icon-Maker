//
//  ImageChooserDialog.swift
//  MacIconMaker
//
//  Created by Miguel Vieira on 14/12/2018.
//  Copyright © 2018 Miguel Vieira. All rights reserved.
//

import Cocoa

var ImageDialog : NSOpenPanel
{
    let dialog = NSOpenPanel()
    dialog.message                 = "Choose an image";
    dialog.showsResizeIndicator    = true;
    dialog.showsHiddenFiles        = false;
    dialog.canChooseDirectories    = false;
    dialog.allowsMultipleSelection = false;
    dialog.allowedFileTypes        = ["png", "jpg", "jpeg"];
    dialog.allowsOtherFileTypes    = false;
    dialog.canChooseFiles          = true;
    
    return dialog;
}

var SaveDialog : NSOpenPanel
{
    let dialog = NSOpenPanel()
    dialog.message                 = "Where do you want to save the images?";
    dialog.showsResizeIndicator    = true;
    dialog.showsHiddenFiles        = false;
    dialog.canChooseDirectories = true;
    dialog.canChooseFiles = false;
    dialog.allowsOtherFileTypes = false;
    dialog.canCreateDirectories = true;
    
    return dialog;
}

func ErrorAlert(withMessage message : String) -> NSAlert
{
    let alert = NSAlert();
    alert.messageText = "Error";
    alert.addButton(withTitle: "Ok");
    alert.informativeText = message;
    
    return alert;
}

func WarningAlert(withMessage message : String) -> NSAlert
{
    let alert = NSAlert();
    alert.messageText = "Warning";
    alert.addButton(withTitle: "Continue");
    alert.informativeText = message;
    
    return alert;
}

struct IconSize
{
    var dimensions : CGSize;
    var name : String;
}
