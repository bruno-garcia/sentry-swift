public struct Hub: ISentryClient {
    var client: SentryClient

    public init(client: SentryClient, options: SentryOptions) {
        self.client = client

        for integration in options.integrations {
            integration.register(hub: self, options: options)
        }
    }

    public func capture(event: SentryEvent) {
        self.client.capture(event: event)
    }
}
