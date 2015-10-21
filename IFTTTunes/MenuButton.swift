//
//  MenuButton.swift
//  IFTTTunesPrefs
//
//  Created by Rotter, Greg on 10/21/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

import Cocoa

class MenuButton: NSObject, NSApplicationDelegate {
    var sendToIFTTT = true
    private let _statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    override init() {
        super.init()
        
        let btn = _statusItem.button!
        
        btn.image = NSImage(named: "color")
        btn.target = self
        btn.action = "onClick"
    }
    
    func onClick() {
        sendToIFTTT = !sendToIFTTT
        
        let str = sendToIFTTT ? "color" : "bw"
        _statusItem.button!.image = NSImage(named: str)
    }
}