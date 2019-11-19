//
//  MenuButton.swift
//  IFTTTunesPrefs
//
//  Created by Rotter, Greg on 10/21/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

import Cocoa

class MenuButton: NSObject, NSApplicationDelegate {
    @objc var sendToIFTTT = true
    fileprivate let _statusItem = NSStatusBar.system.statusItem(withLength: -1)
    
    override init() {
        super.init()
        
        let btn = _statusItem.button!
        
        btn.image = NSImage(named: "color")
        btn.target = self
        btn.action = #selector(MenuButton.onClick)
    }
    
    @objc func onClick() {
        sendToIFTTT = !sendToIFTTT
        
        let str = sendToIFTTT ? "color" : "bw"
        _statusItem.button!.image = NSImage(named: str)
    }
}
