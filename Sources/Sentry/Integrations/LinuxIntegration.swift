#if os(Linux)
import Glibc

internal struct LinuxIntegration: SentryIntegration {
    public func register(hub: Hub, options: SentryOptions) {
        
    }
}

#endif
