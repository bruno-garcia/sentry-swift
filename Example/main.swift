import Sentry

Sentry.start(configure: { o in
    o.dsn = ""
});

Sentry.capture(message: "hi swift!")