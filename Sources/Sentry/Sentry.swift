public class Sentry {
    static private var hub: Hub?

    public static func start(configure: (inout SentryOptions)->()) throws {
        print("Sentry Init")
   
        var options = SentryOptions()
        configure(&options)
        
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        options.add(integration: PLCrashReporterIntegration())
#elseif os(Linux)
        // crashpad
#elseif os(Windows)
        // crashpad
#else
        // throw PlatformNotSupported
#endif

        hub = Hub(client: try SentryClient(options: options), options: options)
    }

    public static func capture(message: String) {
        self.hub?.capture(message: message)
    }

    public static func capture(event: SentryEvent) {
        self.hub?.capture(event: event)
    }
}