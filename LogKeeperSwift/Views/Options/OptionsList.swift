import SwiftUI

struct OptionsList: View {
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
    struct OptionsList_Previews: PreviewProvider {
        static var previews: some View {
            OptionsList().environmentObject(mockStore)
        }
    }
#endif
