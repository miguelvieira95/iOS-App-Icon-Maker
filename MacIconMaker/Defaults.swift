//
//  Defaults.swift
//  MacIconMaker
//
//  Created by Miguel Vieira on 14/12/2018.
//  Copyright © 2018 Miguel Vieira. All rights reserved.
//

import Foundation

var iphoneDimensions = [IconSize(dimensions: CGSize(width: 60, height: 60), name : "iPhone_2x_AppIcon"), IconSize(dimensions: CGSize(width: 120, height: 120), name : "iPhone_3x_AppIcon"), IconSize(dimensions: CGSize(width: 87, height: 87), name : "iPhone_3x_Settings"), IconSize(dimensions: CGSize(width: 60, height: 60), name : "iPhone_3x_Notifications"), IconSize(dimensions: CGSize(width: 120, height: 120), name : "iPhone_3x_Spotlight")];

var iPadDimensions = [IconSize(dimensions: CGSize(width: 29, height: 29), name : "iPad_1x_Settings"), IconSize(dimensions: CGSize(width: 20, height: 20), name : "iPad_1x_Notifications"), IconSize(dimensions: CGSize(width: 40, height: 40), name : "iPad_1x_Spotlight"), IconSize(dimensions: CGSize(width: 76, height: 76), name : "iPad_1x_AppIcon"), IconSize(dimensions: CGSize(width: 152, height: 152), name : "iPad_2x_AppIcon"), IconSize(dimensions: CGSize(width: 167, height: 167), name : "iPad_Pro_2x_AppIcon")];

var universalDimensions = [IconSize(dimensions: CGSize(width: 58, height: 58), name : "iPhone_iPad_2x_Settings"), IconSize(dimensions: CGSize(width: 40, height: 40), name : "iPhone_iPad_2x_Notifications"), IconSize(dimensions: CGSize(width: 80, height: 80), name : "iPhone_iPad_2x_Spotlight"), IconSize(dimensions: CGSize(width: 1024, height: 1024), name : "App_Store")];

var customUserDimensions = [IconSize]()

func AllDimensions() -> [IconSize]
{
    return iphoneDimensions + iPadDimensions + universalDimensions + customUserDimensions;
}
