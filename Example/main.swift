import Sentry

do {
    try Sentry.start(configure: { o in
        o.dsn = "https://82e5a3e0d7044ab582d47d1e4ff1ef2b@o117736.ingest.sentry.io/5414046"
    });
} catch {
    print("Couldn't init Sentry: \(error)")
}



Sentry.capture(message: "hi swift!")

let hey: Int? = nil
// Can't unwrap nil:
// Sentry.capture(message: String(hey!))
