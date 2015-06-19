//
//  LogLevel.swift
//  PAUDPLogger
//
//  Created by Muronaka Hiroaki on 2015/06/15.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import Foundation

enum LogLevel: Int, Printable {
    case None = 0,
    Debug,
    Info,
    Warning,
    Fatal
    
    var description:String {
        get {
            switch(self) {
            case None:
                return "None"
            case Debug:
                return "Debug"
            case Info:
                return "Info"
            case Warning:
                return "Warn"
            case Fatal:
                return "Fatal"
            }
        }
    }
}