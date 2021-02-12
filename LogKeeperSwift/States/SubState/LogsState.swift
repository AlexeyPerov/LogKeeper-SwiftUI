import Foundation

struct LogsState: FluxState {
    var selectedProject: String
    var projects: [String]
    var logs: [LogInfoEntity]
    var logsLoadState: LoadState

    init(selectedProject: String, projects: [String] = [], logs: [LogInfoEntity] = [], logsLoadState : LoadState = LoadState.idle) {
        self.selectedProject = selectedProject
        self.projects = projects
        self.logs = logs
        self.logsLoadState = logsLoadState
    }
}
