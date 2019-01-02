//
//  Defaults.swift
//  MacIconMaker
//
//  Created by Miguel Vieira on 14/12/2018.
//  Copyright © 2018 Miguel Vieira. All rights reserved.
//

import Foundation

var iphoneDimensions = [Icon(dimensions: CGSize(width: 60, height: 60), name : "iPhone_2x_AppIcon"), Icon(dimensions: CGSize(width: 120, height: 120), name : "iPhone_3x_AppIcon"), Icon(dimensions: CGSize(width: 87, height: 87), name : "iPhone_3x_Settings"), Icon(dimensions: CGSize(width: 60, height: 60), name : "iPhone_3x_Notifications"), Icon(dimensions: CGSize(width: 120, height: 120), name : "iPhone_3x_Spotlight")];

var iPadDimensions = [Icon(dimensions: CGSize(width: 29, height: 29), name : "iPad_1x_Settings"), Icon(dimensions: CGSize(width: 20, height: 20), name : "iPad_1x_Notifications"), Icon(dimensions: CGSize(width: 40, height: 40), name : "iPad_1x_Spotlight"), Icon(dimensions: CGSize(width: 76, height: 76), name : "iPad_1x_AppIcon"), Icon(dimensions: CGSize(width: 152, height: 152), name : "iPad_2x_AppIcon"), Icon(dimensions: CGSize(width: 167, height: 167), name : "iPad_Pro_2x_AppIcon")];

var universalDimensions = [Icon(dimensions: CGSize(width: 58, height: 58), name : "iPhone_iPad_2x_Settings"), Icon(dimensions: CGSize(width: 40, height: 40), name : "iPhone_iPad_2x_Notifications"), Icon(dimensions: CGSize(width: 80, height: 80), name : "iPhone_iPad_2x_Spotlight"), Icon(dimensions: CGSize(width: 1024, height: 1024), name : "App_Store")];

var watchDimensions = [
    WatchIcon(dimensions: CGSize(width: 48, height: 48), name : "Watch_38mm_NotificationCenter", role : "notificationCenter", subtype : "38mm"),
    WatchIcon(dimensions: CGSize(width: 55, height: 55), name : "Watch_40_42_44mm_NotificationCenter", role : "notificationCenter", subtype : "42mm"),
    WatchIcon(dimensions: CGSize(width: 80, height: 80), name : "Watch_38mm_AppIcon", role : "appLauncher", subtype : "38mm"),
    WatchIcon(dimensions: CGSize(width: 88, height: 88), name : "Watch_40_42mm_AppIcon", role : "appLauncher", subtype : "42mm"),
    WatchIcon(dimensions: CGSize(width: 100, height: 100), name : "Watch_44mm_AppIcon", role : "appLauncher", subtype : "44mm"),
    WatchIcon(dimensions: CGSize(width: 172, height: 172), name : "Watch_38mm_QuickLook", role : "quickLook", subtype : "38mm"),
    WatchIcon(dimensions: CGSize(width: 196, height: 196), name : "Watch_40_42mm_QuickLook", role : "quickLook", subtype : "42mm"),
    WatchIcon(dimensions: CGSize(width: 216, height: 216), name : "Watch_44mm_QuickLook", role : "quickLook", subtype : "44mm"),
    WatchIcon(dimensions: CGSize(width: 88, height: 88), name : "Watch_44mm_QuickLook", role : "quickLook", subtype : "44mm"),
    WatchIcon(dimensions: CGSize(width: 58, height: 58), name : "Watch_2x_CompanionSettings", role : "companionSettings", subtype : nil),
    WatchIcon(dimensions: CGSize(width: 87, height: 87), name : "Watch_3x_CompanionSettings", role : "companionSettings", subtype : nil)];

var customUserDimensions = [Icon]()

func AllDimensions() -> [Icon]
{
    return iphoneDimensions + iPadDimensions + universalDimensions + customUserDimensions;
}
