import Foundation

protocol LogsRepository {
    func initialize()
}

enum RequestError: Error {
    case noResponse
    case error(error: Error)
}

let emptyLog: LogEntity = LogEntity(project: "", info: LogInfoEntity(id: "", title: "", author: "", createdAt: Date(), contentsId: ""),
                                      data: LogContentEntity(id: "", contents: ""))
