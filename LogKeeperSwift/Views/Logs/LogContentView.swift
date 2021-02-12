import SwiftUI

struct LogContentView: View {
    let log: LogEntity
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(log.info.title)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                                    
                HStack {
                    Text(log.info.author)
                    Spacer()
                    Text(dateFormatter.string(from: log.info.createdAt))
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Text("ID " + log.info.id)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                
                Divider()
                
                let lines = log.data.contents.split(whereSeparator: \.isNewline)
                   
                ForEach(0 ..< lines.count) { value in
                    Text(lines[value])
                }
            }
            .padding()
        }
    }
}

#if DEBUG
struct LogContentView_Previews: PreviewProvider {
    static var previews: some View {
        LogContentView(log: LogEntity(
                    project: "project", info: testLogInfoModels[3], data: LogContentEntity(id: "0", contents: "contents"))).environmentObject(mockStore)
    }
}
#endif
