#if os(tvOS)
import UIKit

internal struct TvOSIntegration: SentryIntegration {
    public func register(hub: Hub, options: SentryOptions) {
        hub.configure(scope: { s in s.tags["os"] = "tvOS" })
    }
}

#endif
