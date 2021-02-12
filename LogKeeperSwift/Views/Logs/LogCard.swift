import SwiftUI

struct LogCard: View {
    @EnvironmentObject var store: AppState
    let log: LogInfoEntity
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: CGFloat(8.0)) {
                Text(log.title).font(.title).lineLimit(2)
                Text(log.author)
                    .foregroundColor(.secondary)
                Text(dateFormatter.string(from: log.createdAt))
                    .foregroundColor(.secondary)
            }.padding(.leading, 8)
        }.padding(8)
    }
}

#if DEBUG
    struct LogCard_Previews: PreviewProvider {
        static var previews: some View {
            LogCard(log: testLogInfoModels[0]).environmentObject(mockStore)
        }
    }
#endif
