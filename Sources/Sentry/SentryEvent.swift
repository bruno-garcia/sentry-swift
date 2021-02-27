
import Foundation

public struct SentryEvent {
    public let id: UUID = UUID()
    public var message: String?
    public var tags: Dictionary<String, String>?

    public init(message: String? = nil, tags: Dictionary<String, String>? = nil) {
        self.message = message
        self.tags = tags
    }
}
