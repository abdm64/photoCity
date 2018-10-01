//
//  detectDevice.swift
//  pixel-city
//
//  Created by ABD on 17/09/2018.
//  Copyright © 2018 ABDM64. All rights reserved.
//

import Foundation



struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT ==  568.0
    static let IS_IPHONE_6_7          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT ==  667.0
    static let IS_IPHONE_6P_7P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT ==  736.0 // 736.0
    static let IS_IPHONEX             = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT ==  812.0
    static let IS_IPHONEXMAX         = UIDevice.current.userInterfaceIdiom == .phone  && ScreenSize.SCREEN_HEIGHT ==  2688.0
    static let IS_IPHONEXR        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT == 1792.0
}
