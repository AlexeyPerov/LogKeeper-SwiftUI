import SwiftUI

struct OptionsCard: View {
    @EnvironmentObject var store: AppState
    let option: Option
    let tapCallback: () -> ()

    var body: some View {
        HStack {
            Image(systemName: option.imageName)
                .imageScale(.large)
                .foregroundColor(.green)
            VStack(alignment: .leading, spacing: CGFloat(8.0)) {
                Text(option.title).font(.title)
                Text(option.description)
                    .foregroundColor(.secondary)
            }.padding(.leading, CGFloat(8.0))
        }
        .padding(8)
        .onTapGesture {
            tapCallback()
        }
    }
}

#if DEBUG
    struct OptionsCard_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                OptionsCard(option: Option(title: "Admin Panel", description: "Firebase", imageName: "square.and.arrow.up"), tapCallback: { })
                OptionsCard(option: Option(title: "Upload Log", description: "", imageName: "square.and.arrow.up"), tapCallback: { })
            }
            .environmentObject(mockStore)
        }
    }
#endif


struct Option {
    let title: String
    let description: String
    let imageName: String
}
