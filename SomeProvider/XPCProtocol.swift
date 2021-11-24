import Foundation
import FileProvider
import SomeProviderCommonPackage

@objc(XPCProtocol)
protocol XPCProtocol {
    func privilegedHi(completion: @escaping (String) -> Void)
    func privilegedAlert()
    func registerEndpoint(_ endpoint: NSXPCListenerEndpoint)
    func getRegisteredEndpoint(completion: @escaping () -> NSXPCListenerEndpoint?)
    func fetchContents(for itemIdentifier: NSFileProviderItemIdentifier, tempURL: URL, completionHandler: @escaping (URL?, FileProviderItem?, Error?) -> Void)
}
