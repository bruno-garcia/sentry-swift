public class Sentry {
    static private var hub: Hub?

    public static func start(configure: (inout SentryOptions)->()) {
        print("Sentry Init")
   
        var options = SentryOptions()
        configure(&options)
        
        // @available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
        options.add(integration: PLCrashReporterIntegration())

        hub = Hub(client: SentryClient(options: options), options: options)
    }

    static func 

    public static func capture(message: String) {
        self.hub?.capture(message: message)
    }

    public static func capture(event: SentryEvent) {
        self.hub?.capture(event: event)
    }
}