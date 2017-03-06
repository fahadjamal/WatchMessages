//
//  InterfaceController.swift
//  WatchNotification WatchKit Extension
//
//  Created by Fahad Jamal on 2/27/17.
//  Copyright © 2017 Fahad Jamal. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        NSLog("session did receive application context 1")
    }
    
    @IBOutlet var notificationLabel : WKInterfaceLabel!
    @IBOutlet var exampleButton : WKInterfaceButton!
    
    let session = WCSession.default()
    
    // MARK: - Default Init Method -
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        session.delegate = self
        session.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let  paragraphStyle  = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right;
        
        let attributedString : NSAttributedString = NSAttributedString(string: "Hello", attributes: [NSParagraphStyleAttributeName : paragraphStyle])
        exampleButton.setAttributedTitle(attributedString)
    }
    
    // MARK: - WCSessionDelegate Method -
    
    func  session (_ session : WCSession, didReceiveMessage  message:[String:Any]) {
        let colors : String = message["Action"] as! String
        notificationLabel.setText(colors)
        NSLog("session did receive application context")
        
         WKInterfaceDevice.current().play(.notification)
        //WKInterfaceDevice.current().play(.click)
    }
    
    // MARK: - Button Action Method -
    
    @IBAction func exampleButtonTapped() {
        print("exampleButtonTapped")
        session.sendMessage(["Watch Alert" : "Watch Button Tapped"], replyHandler: nil) { (error) in
            print("Watch Message Sending Error \(error)")
        }
    }
    
    // MARK: - Default De-Init Method -
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
