//
//  FileProviderExtension.swift
//  SomeProvider
//
//  Created by Peter Thomas Horn on 09.03.21.
//

import FileProvider

class FileProviderExtension: NSObject, NSFileProviderReplicatedExtension {
    var manager: NSFileProviderManager
    required init(domain: NSFileProviderDomain) {
        self.manager = NSFileProviderManager(for: domain)!
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
        // TODO: implement fetching of the contents for the itemIdentifier at the specified version
        
        NSLog("fetchContents")
//        completionHandler(nil, nil, NSError(domain: NSCocoaErrorDomain, code: NSFeatureUnsupportedError, userInfo:[:]))
        do {
            var itemPath = try self.manager.temporaryDirectoryURL()
            itemPath.appendPathComponent("content")
            let data: Data? = "foo Blablabla".data(using: .utf8)
            try data!.write(to: itemPath)
            NSLog(itemPath.path)
            completionHandler(itemPath, FileProviderItem(identifier: itemIdentifier, size: data!.count), nil)
        }
        catch {
            NSLog("failed fetching contents")
        }
        NSLog("done")
        let progress = Progress(totalUnitCount: 4)
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
