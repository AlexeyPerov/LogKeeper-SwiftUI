import SwiftUI

struct ProjectCard: View {
    @EnvironmentObject var store: AppState
    let project: String
    let selected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(LinearGradient(
                    gradient: .init(colors: [Color(UIColor.systemGray2), Color(UIColor.systemGray6)]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 0.6)
                ))
                .border(Color.black, width: selected ? 1 : 0)
            
            VStack {
                Text(project)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 120)
        .onTapGesture {
            store.dispatch(action: LogActions.SelectProjectRequest(store: store, project: project))
        }
    }
}

#if DEBUG
struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProjectCard(project: "AoC Pre Prod", selected: false)
            ProjectCard(project: "AoC Dev", selected: true)
        }
        .environmentObject(mockStore)
    }
}
#endif
