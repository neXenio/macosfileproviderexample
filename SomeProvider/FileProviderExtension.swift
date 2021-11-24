//
//  FileProviderExtension.swift
//  SomeProvider
//
//  Created by Peter Thomas Horn on 09.03.21.
//

import FileProvider
import Foundation
import SomeProviderCommonPackage

class FileProviderExtension: NSObject, NSFileProviderReplicatedExtension {
    var manager: NSFileProviderManager
    var xpcHandler: XPCHandler
    required init(domain: NSFileProviderDomain) {
        self.manager = NSFileProviderManager(for: domain)!
        self.xpcHandler = XPCHandler()
        xpcHandler.run()
        super.init()
    }
    
    func invalidate() {
        // TODO: cleanup any resources
    }
    
    func item(for identifier: NSFileProviderItemIdentifier, request: NSFileProviderRequest, completionHandler: @escaping (NSFileProviderItem?, Error?) -> Void) -> Progress {
        // resolve the given identifier to a record in the model
        
        // TODO: implement the actual lookup
        completionHandler(FileProviderItem(identifier: identifier, size: 0), nil)
//        completionHandler(FileProviderItem(identifier: identifier), NSError(domain: NSFileProviderErrorDomain, code: NSFileProviderError.Code.noSuchItem.rawValue))
        return Progress()
    }
    
    func fetchContents(for itemIdentifier: NSFileProviderItemIdentifier, version requestedVersion: NSFileProviderItemVersion?, request: NSFileProviderRequest, completionHandler: @escaping (URL?, NSFileProviderItem?, Error?) -> Void) -> Progress {
        // TODO: implement fetching of the contents for the itemIdentifier at the specified version\

        let progress = Progress(totalUnitCount: 110)
        
        NSLog("fetchContents")
        do {
            let itemPath = try self.manager.temporaryDirectoryURL()
            progress.becomeCurrent(withPendingUnitCount: 90)
            if let xpc = xpcHandler.connection!.remoteObjectProxy() as? XPCProtocol {
                xpc.fetchContents(for: itemIdentifier, tempURL: itemPath, completionHandler: { url, item, error in
                    NSLog(url!.path)
                    completionHandler(url, item, error)})
            }
            progress.resignCurrent()
        }
        catch {
            NSLog("failed fetching contents")
        }
        progress.becomeCurrent(withPendingUnitCount: 20)
        NSLog("done")
        progress.resignCurrent()
        return progress
    }

    func createItem(basedOn itemTemplate: NSFileProviderItem, fields: NSFileProviderItemFields, contents url: URL?, options: NSFileProviderCreateItemOptions = [], request: NSFileProviderRequest, completionHandler: @escaping (NSFileProviderItem?, NSFileProviderItemFields, Bool, Error?) -> Void) -> Progress {
        // TODO: a new item was created on disk, process the item's creation
        
        print("Created Item")
        completionHandler(itemTemplate, [], false, nil)
        return Progress()
    }
    
    func modifyItem(_ item: NSFileProviderItem, baseVersion version: NSFileProviderItemVersion, changedFields: NSFileProviderItemFields, contents newContents: URL?, options: NSFileProviderModifyItemOptions = [], request: NSFileProviderRequest, completionHandler: @escaping (NSFileProviderItem?, NSFileProviderItemFields, Bool, Error?) -> Void) -> Progress {
        // TODO: an item was modified on disk, process the item's modification
        
        NSLog("modifyItem")
        completionHandler(item, [], false, nil)//NSError(domain: NSCocoaErrorDomain, code: NSFeatureUnsupportedError, userInfo:[:]))
        return Progress()
    }
    
    func deleteItem(identifier: NSFileProviderItemIdentifier, baseVersion version: NSFileProviderItemVersion, options: NSFileProviderDeleteItemOptions = [], request: NSFileProviderRequest, completionHandler: @escaping (Error?) -> Void) -> Progress {
        // TODO: an item was deleted on disk, process the item's deletion
        
        NSLog("Deleted item \(identifier.rawValue)")
        completionHandler(NSError(domain: NSCocoaErrorDomain, code: NSFeatureUnsupportedError, userInfo:[:]))
        return Progress()
    }
    
    func enumerator(for containerItemIdentifier: NSFileProviderItemIdentifier, request: NSFileProviderRequest) throws -> NSFileProviderEnumerator {
        return FileProviderEnumerator(enumeratedItemIdentifier: containerItemIdentifier)
    }
}
