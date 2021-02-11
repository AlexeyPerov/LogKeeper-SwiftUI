import Foundation

struct LogsState: FluxState {
    var selectedProject: String
    var projects: [String]
    var logs: [LogInfoEntity]
    var hasError: Bool

    init(selectedProject: String, projects: [String] = [], logs: [LogInfoEntity] = [], hasError : Bool = false) {
        self.selectedProject = selectedProject
        self.projects = projects
        self.logs = logs
        self.hasError = hasError
    }
}
