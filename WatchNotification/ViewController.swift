//
//  ViewController.swift
//  WatchNotification
//
//  Created by Fahad Jamal on 2/27/17.
//  Copyright © 2017 Fahad Jamal. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(iOS 9.3, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith")
    }
    
    @IBOutlet var notificationButton : UIButton!
              var session: WCSession!
    
    //MARK: - Default Init Method -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if (WCSession.isSupported()) {
            session = WCSession.default()
            session.delegate = self
            session.activate()
            
            NSLog("%@", "Paired Watch: \(session.isPaired), Watch App Installed: \(session.isWatchAppInstalled)")
        }
        else {
            print("WCSession not supported (f.e. on iPad).")
        }
    }
    
    //MARK: - WCSessionDelegate Method -
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let watchStatus : String = message["Watch Alert"] as! String
        print("watchStatus is \(watchStatus)")
        
        NSLog("session did receive application context")
    }
    
    //MARK: - Button Action Method -
    
    @IBAction func notificationButtonTapped(_sender : Any) {
        print("notificationButtonTapped");
        session.sendMessage(["Action": "Button Tapped"], replyHandler: nil, errorHandler: { (error) in
            NSLog("%@", "Error sending message: \(error)")
        })
    }
    
    //MARK: - Default De-Init Method -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.notificationButton = nil
    }
    
}
