import Foundation

protocol LogsRepository {
    func initialize()
    func getProjects(completionHandler: @escaping (Result<[String], RequestError>) -> Void)
    func getLogsForProject(project: String, completionHandler: @escaping (Result<[LogInfoEntity], RequestError>) -> Void)
    func getLog(project: String, id: String, completionHandler: @escaping (Result<LogEntity, RequestError>) -> Void)
    func getAdminLink() -> String
}

enum RequestError: Error {
    case noResponse
    case error(error: Error)
}

let emptyLog: LogEntity = LogEntity(project: "", info: LogInfoEntity(id: "", title: "", author: "", createdAt: Date(), contentsId: ""),
                                      data: LogContentEntity(id: "", contents: ""))
