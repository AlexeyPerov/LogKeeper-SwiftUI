import SwiftUI

struct LogDetailsScreen: View {
    @EnvironmentObject var store: AppState
    
    let project: String
    let id: String
    
    var body: some View {
        VStack {
            if (store.logContentsState.loadState == LoadState.idle) {
                Text("...")
                    .onAppear {
                        store.dispatch(action: LogContentsActions.LoadLogRequest(store: store, project: project, id: id))
                    }
            } else if (store.logContentsState.loadState == LoadState.loading) {
                ProgressView()
            } else if (store.logContentsState.loadState == LoadState.loaded) {
                LogContentView(log: store.logContentsState.log)
                    .navigationTitle(project)
                    .padding()
            }
        }
        .onDisappear {
            store.dispatch(action: LogContentsActions.LogReleased())
        }
    }
}

#if DEBUG
struct LogDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogDetailsScreen(project: "", id: "")
            .environmentObject(mockStore)
    }
}
#endif
