import Foundation

struct LogContentsActions {
    struct LoadLogRequest: Action {
        init(store: AppState, project: String, id: String) {
            store.dispatch(action: LoadStarted())
            store.repository.getLog(project: project, id: id) {
                (result: Result<LogEntity, RequestError>) in
                switch result {
                case let .success(response):
                    store.dispatch(action: LogLoaded(log: response))
                    break
                case .failure:
                    break
                }
            }
        }
    }
    
    struct LoadStarted: Action {
    }
    
    struct LogLoaded: Action {
        let log: LogEntity
    }
    
    struct LogReleased: Action {
    }
}
