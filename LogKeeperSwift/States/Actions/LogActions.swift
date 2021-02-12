import Foundation

struct LogActions {
    struct GetProjectsRequest: Action {
        init(store: AppState) {
            store.repository.getProjects() {
                (result: Result<[String], RequestError>) in
                switch result {
                case let .success(response):
                    store.dispatch(action: ProjectsUpdated(projects: response))
                    if (response.count > 0 && store.logsState.selectedProject.isEmpty) {
                        store.dispatch(action: SelectProjectRequest(store: store, project: response[0]))
                    }
                    break
                case .failure:
                    break
                }
            }
        }
    }
            
    struct SelectProjectRequest: Action {
        init(store: AppState, project: String) {
            store.dispatch(action: SelectedProjectUpdated(project: project))
            store.dispatch(action: LogsLoadStarted())
            
            store.repository.getLogsForProject(project: project) {
                (result: Result<[LogInfoEntity], RequestError>) in
                switch result {
                case let .success(response):
                    store.dispatch(action: LogsUpdated(logs: response))
                    break
                case .failure:
                    break
                }
            }
        }
    }
    
    struct SelectedProjectUpdated: Action {
        let project: String
    }
        
    struct ProjectsUpdated: Action {
        let projects: [String]
    }
        
    struct LogsLoadStarted: Action {
    }
    
    struct LogsUpdated: Action {
        let logs: [LogInfoEntity]
    }
}
