//
//  UDPLogWriter.swift
//  PAUDPLogger
//
//  Created by MuronakaHiroaki on 2015/06/16.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import Foundation

// 最初にコネクションのあった先に出力するロガー
class UDPLogWriter : LogWriterDelegate, GCDAsyncUdpSocketDelegate {
    
    static let TimeoutTimeInterval:NSTimeInterval = 5
    
    var recvPort:UInt16
    var sendPort:UInt16
    var sendHost:String? = nil
    
    var sendQueue:dispatch_queue_t!
    
    var udpSocket:GCDAsyncUdpSocket? = nil
    
    init(recvPort: UInt16, queueName:String) {
        self.recvPort = recvPort
        self.sendPort = 0
        self.sendQueue = dispatch_queue_create(strdup(queueName), nil)
    }
    
    func start() -> Bool {
        
        if udpSocket != nil {
            println("UDPLogWriter is already running")
            return false
        }
        
        udpSocket = GCDAsyncUdpSocket()
        udpSocket?.setDelegate(self)
        
        return true
    }
    
    func stop() {
        if udpSocket == nil {
            return
        }
        
        self.udpSocket?.close()
        self.udpSocket = nil
    }
    
    private func printLogImpl(message: String) {
        self.udpSocketSendString(message)
    }
    
    // MARK: -
    // MARK: recv
    
    // なんらかのデータグラムの送信元を、ログの送信先とする。
    // なんらかのヘルスチェクくらいはした方がよいかも。
    // でないと受けてがいないのに、送信し続けてしまう。
    func udpSocket(sock: GCDAsyncUdpSocket!, didReceiveData data: NSData!, fromAddress address: NSData!, withFilterContext filterContext: AnyObject!) {
        
        var host:NSString?
        var port:UInt16 = 0
        
        GCDAsyncUdpSocket.getHost(&host, port: &port, fromAddress: data)
        
        sendHost = host as? String
        sendPort = port
    }
    
    
    // MARK: -
    // MARK: send
    
    private func udpSocketSendString(message: String) {
        
        dispatch_async(self.sendQueue!, {  () -> Void  in
            if self.udpSocket == nil || self.sendHost == nil {
                return
            }
            let data = message.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            self.udpSocket?.sendData(data!, toHost: self.sendHost!, port: self.sendPort, withTimeout: UDPLogWriter.TimeoutTimeInterval, tag: 0)
        })

    }
    
    // MARK: -
    // MARK: LogWriterDelegate
    func printLog(message: String) {
        printLogImpl(message)
        
    }
}


