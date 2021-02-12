import Combine
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: AppState
    @State var selectedTab = Tab.logs
    
    enum Tab: Int {
        case options, logs
    }
    
    var body: some View {
        TabView(selection: self.$selectedTab) {
            LogsListScreen().tabItem{ VStack { Image(systemName: "checkmark.circle.fill"); Text("Logs") } }.tag(Tab.logs)
            OptionsListScreen().tabItem{ VStack { Image(systemName: "pencil.circle"); Text("Options") } }.tag(Tab.options)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        return
            HomeView()
            .environmentObject(mockStore)
    }
}
#endif
