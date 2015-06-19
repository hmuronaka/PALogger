//
//  LogWriter.swift
//  PAUDPLogger
//
//  Created by Muronaka Hiroaki on 2015/06/15.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import Foundation

protocol LogWriterDelegate {
    func printLog(message:String);
}

protocol LogMessageFormatterDelegate {
    func format(datetime:NSDate!, logLevel:LogLevel, message:String)
}


class LogWriter {
    
    var delegate:LogWriterDelegate?
    
    var formatter:LogMessageFormatter?
    
    var logLevel:LogLevel
    
    convenience init() {
        self.init(logLevel:LogLevel.Info)
    }
    
    init(logLevel:LogLevel, formatter:LogMessageFormatter) {
        self.logLevel = logLevel
        self.formatter = formatter
    }
    
    func log(logLevel:LogLevel, message:String) {
        if !isOutput(logLevel) {
            return
        }
        
        delegate?.printLog(message)
    }
    
    func info(message:String) {
        log(LogLevel.Info, message:message)
    }
    
    func debug(message:String) {
        log(LogLevel.Debug, message:message)
    }
    
    func warn(message:String) {
        log(LogLevel.Warning, message:message)
    }
    
    func fatal(message:String) {
        log(LogLevel.Fatal, message:message)
    }
    
    private func isOutput(logLevel:LogLevel) -> Bool {
        return self.logLevel.rawValue <= logLevel.rawValue
    }
    
    
}