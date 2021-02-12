import SwiftUI

struct OptionsListScreen: View {
    @EnvironmentObject var store: AppState

    var body: some View {
        NavigationView {
            List {
                OptionsCard(option: Option(title: "Admin Panel", description: "Firebase", imageName: "square.and.arrow.up"),
                                           tapCallback: {
                                            guard let url = URL(string: "https://stackoverflow.com") else { return }
                                            UIApplication.shared.open(url)
                                           })
            }
            .navigationBarTitle(Text("Options"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
    struct OptionsListScreen_Previews: PreviewProvider {
        static var previews: some View {
            OptionsListScreen().environmentObject(mockStore)
        }
    }
#endif
