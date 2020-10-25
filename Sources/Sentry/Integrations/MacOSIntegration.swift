#if os(macOS)
import Darwin
import Cocoa

internal struct MacOSIntegration: SentryIntegration {
    public func register(hub: Hub, options: SentryOptions) {
        
    }
}

#endif
