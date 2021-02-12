import Foundation

struct LogContentsState: FluxState {
    var log: LogEntity
    var loadState: LoadState

    init(log: LogEntity, loadState: LoadState) {
        self.log = log
        self.loadState = loadState
    }
}
