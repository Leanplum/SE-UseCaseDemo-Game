//
//  config.swift
//  Leanplum Game Demo - Tic Tac Toe
//
//  Created by Zach Owens on 12/12/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import Foundation

public let appKey:String = "app_S8Yt8OeAK2Ovgrq0F8Je3S3V8g0U4ar8Cv2E7e9Lgz0"
public let devKey:String = "dev_308Z1YC7TgWSLlFPvcf3c0WtbazKAwpEegElKcDZe9A"
public let prodKey:String = "prod_EZkrxXnONTH47uKBLr3taZkgTcNUIupgP5sFGMPYzF0"

public var onboardTrack = LPVar.define("onboard", with: false)
public var LPindex = LPVar.define("LPindex", with: 1 )
public var welcomeText = LPVar.define("welcomeText", with: "Welcome to TicTacToe")
public var userId = LPVar.define("username", with: "")
public var smallPrice = LPVar.define("smallPrice", with: 1.99)
public var largePrice = LPVar.define("largePrice", with: 4.99)
public var btnRadius = LPVar.define("radius", with: 4.0)
public var companyNameTitle = LPVar.define("companyNameTitle", with: "LEANPLUM DEMO")
public var picture1 = LPVar.define("picture1", withFile: "image4.png")
public var picture2 = LPVar.define("picture2", withFile: "image4.png")
public var picture3 = LPVar.define("picture3", withFile: "image4.png")
