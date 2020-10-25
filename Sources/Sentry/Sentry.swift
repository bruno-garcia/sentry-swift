public class Sentry {
    static private var hub: Hub?

    public static func start(configure: (inout SentryOptions)->()) throws {
        print("Sentry Init")
   
        var options = SentryOptions()
        configure(&options)
        
#if os(macOS)
        options.add(integration: MacOSIntegration())
#elseif os(iOS)
        options.add(integration: IOSIntegration())
#elseif os(watchOS)
        options.add(integration: WatchOSIntegration())
#elseif os(tvOS)
        options.add(integration: TvOSIntegration())
#elseif os(Linux)
        options.add(integration: LinuxIntegration())
        // crashpad
#elseif os(Windows)
        options.add(integration: WindowsIntegration())
        // crashpad
#else
        // throw PlatformNotSupported
#endif

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        options.add(integration: PLCrashReporterIntegration())
#endif

        hub = Hub(client: try SentryClient(options: options), options: options)
    }

    public static func close() {
        self.hub?.close()
    }

    public static func capture(message: String, configureScope: ((inout Scope) -> Void)? = nil) {
        self.hub?.capture(message: message, configureScope: configureScope)
    }

    public static func capture(event: SentryEvent, configureScope: ((inout Scope) -> Void)? = nil) {
        self.hub?.capture(event: event, configureScope: configureScope)
    }

    public static func configure(scope: (inout Scope) -> Void) {
        self.hub?.configure(scope: scope)
    }
}