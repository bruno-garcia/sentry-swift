import CrashReporter

public struct PLCrashReporterIntegration: SentryIntegration {
    public func register(hub: Hub, options: SentryOptions) {
        setupCrashReporting()
    }

    func setupCrashReporting() { 
        let config = PLCrashReporterConfig()
        guard let reporter = PLCrashReporter(configuration: config) else {
            print("PLCrashReporter did not initialize")
            return
        }

        if reporter.hasPendingCrashReport() {
            handleCrashReport(reporter)
        }
        print("No pending crash reports")

        if !reporter.enable() {
            print("PLCrashReporter is disabled")
        }
    }

    func handleCrashReport(_ crashReporter: PLCrashReporter) {
        guard let crashData = try? crashReporter.loadPendingCrashReportDataAndReturnError(), let report = try? PLCrashReport(data: crashData), !report.isKind(of: NSNull.classForCoder()) else {
            crashReporter.purgePendingCrashReport()
            return
        }

        let crash: NSString = PLCrashReportTextFormatter.stringValue(for: report, with: PLCrashReportTextFormatiOS)! as NSString
        print("PLCrashReporter is disabled \(crash)")
        crashReporter.purgePendingCrashReport()
    }
}