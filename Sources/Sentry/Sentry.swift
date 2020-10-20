public struct SentryOptions {
    public var dsn: String?
}

public class Sentry {
    public static func start(configure: (inout SentryOptions)->()) {
        var options = SentryOptions()
        configure(&options)
    }
    public static func capture(message: String) {
        print("captured: " + message)
    }
}
