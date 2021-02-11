import Foundation

struct LogStateReducer: Reducer {
    func reduce(state: LogsState, action: Action) -> LogsState {
        var state = state

        if let action = action as? LogActions.ProjectsUpdated {
            let projects = action.projects
            state.projects = projects
        }

        if let action = action as? LogActions.SelectedProjectUpdated {
            state.selectedProject = action.project
        }

        if let action = action as? LogActions.LogsUpdated {
            state.logs = action.logs
        }

        return state
    }
}
