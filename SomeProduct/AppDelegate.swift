//
//  AppDelegate.swift
//  SomeProduct
//
//  Created by Peter Thomas Horn on 09.03.21.
//

import Cocoa
import FileProvider

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let identifier = NSFileProviderDomainIdentifier(rawValue: "myFiles")
        let domain = NSFileProviderDomain(identifier: identifier, displayName: "Some Domain")

        NSFileProviderManager.add(domain) { error in
            guard let error = error else {
                return
            }

            NSLog(error.localizedDescription)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

