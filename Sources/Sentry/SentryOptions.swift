public class SentryOptions {
    public var dsn: String?
    private var _integrations = [SentryIntegration]()

    public var beforeSend: ((inout SentryEvent) -> SentryEvent?)?

    public var integrations: [SentryIntegration]! {
        get { return _integrations }
    }
}

public extension SentryOptions {
    func add(integration: SentryIntegration) {
        _integrations.append(integration)
    }
}

public protocol SentryIntegration {
    func register(hub: Hub, options: SentryOptions)
}