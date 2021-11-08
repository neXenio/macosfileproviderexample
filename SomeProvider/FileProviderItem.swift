//
//  FileProviderItem.swift
//  SomeProvider
//
//  Created by Peter Thomas Horn on 09.03.21.
//

import FileProvider
import UniformTypeIdentifiers

class FileProviderItem: NSObject, NSFileProviderItem {

    // TODO: implement an initializer to create an item from your extension's backing model
    // TODO: implement the accessors to return the values from your extension's backing model
    
    private let identifier: NSFileProviderItemIdentifier
    private let size: NSNumber
    
    init(identifier: NSFileProviderItemIdentifier, size: Int) {
        self.identifier = identifier
        self.size = NSNumber(value: size)
    }
    
    var itemIdentifier: NSFileProviderItemIdentifier {
        return identifier
    }
    
    var parentItemIdentifier: NSFileProviderItemIdentifier {
        return .rootContainer
    }
    
    var documentSize: NSNumber? {
        return self.size
    }
    
    var lastUsedDate: Date? {
        return Date.now
    }
    
    var capabilities: NSFileProviderItemCapabilities {
        let result: NSFileProviderItemCapabilities = [
            .allowsAddingSubItems,
            .allowsContentEnumerating,
            .allowsDeleting,
            .allowsReading,
            .allowsRenaming,
            .allowsReparenting,
            .allowsWriting,
            .allowsEvicting,
            .allowsExcludingFromSync,
            .allowsTrashing
        ]
        return result
    }
    
    var itemVersion: NSFileProviderItemVersion {
        NSFileProviderItemVersion(contentVersion: "a content version".data(using: .utf8)!, metadataVersion: "a metadata version".data(using: .utf8)!)
    }
    
    var filename: String {
        return identifier.rawValue
    }
    
    var contentType: UTType {
        return identifier == NSFileProviderItemIdentifier.rootContainer ? .folder : .plainText
    }
}
