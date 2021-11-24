import Foundation
import AppKit
import FileProvider
import SomeProviderCommonPackage

class XPCHandler: NSObject, NSXPCListenerDelegate, XPCProtocol {
    var listener: NSXPCListener
    var connection: NSXPCConnection?
    
    public override init() {
        listener = NSXPCListener.anonymous()
        super.init()
        listener.delegate = self
    }
    
    public func run() {
        let connectionToService = NSXPCConnection.init(machServiceName: "com.nexenio.SomeProviderXPCService")
        connectionToService.remoteObjectInterface = NSXPCInterface.init(with: XPCProtocol.self)
        connectionToService.resume()

        if let xpc = connectionToService.remoteObjectProxy() as? XPCProtocol {
            xpc.registerEndpoint(listener.endpoint)
        }
        
        listener.resume()
    }
    
    func registerEndpoint(_ endpoint: NSXPCListenerEndpoint) {
        connection = NSXPCConnection.init(listenerEndpoint: endpoint)
        connection!.remoteObjectInterface = NSXPCInterface.init(with: XPCProtocol.self)
        connection!.resume()
        NSLog("Got new endpoint")
        
        if let xpc = connection!.remoteObjectProxy() as? XPCProtocol {
            xpc.privilegedAlert()
        }
    }
    
    func getRegisteredEndpoint(completion: @escaping () -> NSXPCListenerEndpoint?) {
    }
    
    
    func privilegedAlert() {
        NSLog("Got it!")
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "This is a privileged alert from the Provider"
            alert.informativeText = "You got me!"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    func privilegedHi(completion: @escaping (String) -> Void) {
        completion("Privileged hi! My GID is \(getgid())")
    }
    
    
    func fetchContents(for itemIdentifier: NSFileProviderItemIdentifier, tempURL: URL, completionHandler: @escaping (URL?, FileProviderItem?, Error?) -> Void) {}
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: XPCProtocol.self)
        newConnection.exportedObject = self
        newConnection.resume()
    
        return true
    }
    
    
}
