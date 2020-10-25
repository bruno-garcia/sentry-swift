
import Foundation

public struct SentryEvent {
    public let id: UUID = UUID()
    public var message: String?
    public var tags: Dictionary<String, String>?
}