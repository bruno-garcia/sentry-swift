public protocol ISentryClient {
    func capture(event: SentryEvent)
}

public struct SentryClient: ISentryClient {
    private let options: SentryOptions

    public init (options: SentryOptions) {
        self.options = options
    }

    public func capture(event: SentryEvent) {
        print("capturing event..")
    }
}

public extension ISentryClient {
    func capture(message: String) {
        capture(event: SentryEvent(message: message))
    }
}

public struct SentryEvent {
    public var message: String?
}