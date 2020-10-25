// https://github.com/microsoft/plcrashreporter#prerequisites
// Minimum supported platforms: iOS 9, macOS 10.9, tvOS 9, Mac Catalyst 13.0.
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import CrashReporter

public struct PLCrashReporterIntegration: SentryIntegration {
    public func register(hub: Hub, options: SentryOptions) {
        let config = PLCrashReporterConfig()
        guard let reporter = PLCrashReporter(configuration: config) else {
            print("PLCrashReporter did not initialize")
            return
        }

        if !reporter.enable() {
            print("PLCrashReporter is disabled")
        }

        if reporter.hasPendingCrashReport() {
            guard let crashData = try? reporter.loadPendingCrashReportDataAndReturnError(), 
            let report = try? PLCrashReport(data: crashData), !report.isKind(of: NSNull.classForCoder()) else {
                reporter.purgePendingCrashReport()
                return
            }

            hub.capture(message: "PLCrashReporter OS: \(report.systemInfo.operatingSystem)")

#if DEBUG
            let crash: NSString = PLCrashReportTextFormatter.stringValue(for: report, with: PLCrashReportTextFormatiOS)! as NSString
            print("Crash details:\n\n\(crash)")
            reporter.purgePendingCrashReport()
#endif        
        } else {
            print("No pending crash reports")
        }
    }
}
#endif