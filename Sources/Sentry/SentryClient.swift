import Foundation

public protocol ISentryClient {
    func capture(event: SentryEvent)
}

enum SentryInitError: Error {
    case dsnNull
    case dsnInvalidUrl(dsn: String)
    case dsnInvalid(url: URL)
}

public struct SentryClient: ISentryClient {
    private let options: SentryOptions
    private let dsn: Dsn

    public init(options: SentryOptions) throws {
        self.options = options

        guard let dsnStr = options.dsn else {
            throw SentryInitError.dsnNull
        }
        guard let dsnUrl = URL(string: dsnStr) else {
            print("The DSN provided isn't a valid URL")
            throw SentryInitError.dsnInvalidUrl(dsn: dsnStr)
        }
        self.dsn = try Dsn(dsn: dsnUrl)
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

internal struct Dsn {
    public let envelope: URL
    public let publicKey: String

    public init(dsn: URL) throws {
        guard let publicKey = dsn.user?.components(separatedBy: [","])[0] else {
            throw SentryInitError.dsnInvalid(url: dsn)
        }
        self.publicKey = publicKey
        if let last = dsn.absoluteString.lastIndex(of: "/") {
            let project = String(dsn.absoluteString.suffix(from: dsn.absoluteString.index(last, offsetBy: 1)))

            if dsn.host != nil && dsn.scheme != nil && dsn.scheme!.starts(with: "http") {
                if let envelopeUrl = URL(string: "\(dsn.scheme!)://\(dsn.host!):\(dsn.port ?? (dsn.scheme == "https" ? 443 : 80))/api/\(project)/envelope/") {
                    envelope = envelopeUrl
                    return
                }
            }
        }

        throw SentryInitError.dsnInvalid(url: dsn)
    }
}