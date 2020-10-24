import Sentry

Sentry.start(configure: { o in
    o.dsn = ""
});

Sentry.capture(message: "hi swift!")

let hey: Int? = nil
// Can't unwrap nil:
Sentry.capture(message: String(hey!))
