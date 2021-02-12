import SwiftUI

struct LogsListScreen: View {
    @EnvironmentObject var store: AppState
    @State var appeared: Bool = false
    
    var projectsSection: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 10) {
                    ForEach(store.logsState.projects, id: \.self) { project in
                        ProjectCard(project: project, selected: project == store.logsState.selectedProject)
                    }
                }
            }
        }
    }
    
    var logsSection: some View {
        Section {
            ForEach(store.logsState.logs) { logInfo in
                NavigationLink(destination: LogDetailsScreen(project: store.logsState.selectedProject, id: logInfo.id)) {
                    LogCard(log: logInfo)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                projectsSection
                
                if (store.logsState.logsLoadState == LoadState.loading) {
                    ProgressView()
                } else {
                    logsSection
                }
            }
            .navigationBarTitle(Text("Logs"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            if (!appeared) {
                store.dispatch(action: LogActions.GetProjectsRequest())
            } else {
                appeared = true;
            }
        }
    }
}

#if DEBUG
struct LogsList_Previews: PreviewProvider {
    static var previews: some View {
        LogsListScreen().environmentObject(mockStore)
    }
}
#endif
