import Combine
import Foundation
import SwiftUI

final class AppState: ObservableObject {
    var didChange = PassthroughSubject<AppState, Never>()
    
    @Published var logsState: LogsState
    @Published var logContentsState: LogContentsState
    
    init(logsState: LogsState = LogsState(selectedProject: "", projects: [], logs: []), logContentsState: LogContentsState = LogContentsState(log: emptyLog, loadState: LoadState.idle)) {
        self.logsState = logsState
        self.logContentsState = logContentsState
    }
    
    func dispatch(action: Action) {
        let actionType = type(of: action)
        print("Reduce: '\(actionType)'")
        
        logsState = LogStateReducer().reduce(state: logsState, action: action)
        logContentsState = LogContentsStateReducer().reduce(state: logContentsState, action: action)
        
        DispatchQueue.main.async {
            self.didChange.send(self)
        }
    }
}

let store = AppState()

#if DEBUG
let mockStore = AppState(
    logsState: LogsState(selectedProject: "", projects: ["1", "2"], logs: testLogInfoModels)
)
#endif
