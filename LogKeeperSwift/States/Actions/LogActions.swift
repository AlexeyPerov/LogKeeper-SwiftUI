import Foundation

struct LogActions {
    struct GetProjectsRequest: Action {
        init() {
            MockLogsRepository.shared.getProjects() {
                (result: Result<[String], RequestError>) in
                switch result {
                case let .success(response):
                    store.dispatch(action: ProjectsUpdated(projects: response))
                    if (response.count > 0 && store.logsState.selectedProject.isEmpty) {
                        store.dispatch(action: SelectProjectRequest(project: response[0]))
                    }
                    break
                case .failure:
                    break
                }
            }
        }
    }
            
    struct SelectProjectRequest: Action {
        init(project: String) {
            store.dispatch(action: SelectedProjectUpdated(project: project))
            
            MockLogsRepository.shared.getLogsForProject(project: project) {
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
        
    struct LogsUpdated: Action {
        let logs: [LogInfoEntity]
    }
}
