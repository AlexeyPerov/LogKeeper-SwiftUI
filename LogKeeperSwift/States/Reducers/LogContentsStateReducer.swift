import Foundation

struct LogContentsStateReducer: Reducer {
    func reduce(state: LogContentsState, action: Action) -> LogContentsState {
        var state = state

        if let action = action as? LogContentsActions.LogLoaded {
            state.log = action.log
            state.loadState = LoadState.loaded
        }
        
        if let action = action as? LogContentsActions.LoadStarted {
            state.loadState = LoadState.loading
        }
        
        if let action = action as? LogContentsActions.LogReleased {
            state.loadState = LoadState.idle
        }
        
        return state
    }
}
