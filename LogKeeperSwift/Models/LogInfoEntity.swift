import SwiftUI

struct LogInfoEntity: Equatable, Hashable, Codable, Identifiable {
    let id: String
    let title: String
    let author: String
    let createdAt: Date
    let contentsId: String
}
