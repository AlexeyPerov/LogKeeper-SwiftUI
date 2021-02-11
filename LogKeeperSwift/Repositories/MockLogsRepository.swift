import Foundation

struct MockLogsRepository {
    static let shared = MockLogsRepository()
    
    func getProjects(completionHandler: @escaping (Result<[String], RequestError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let result = ["Project 1", "Project 2", "Project 3"]
            completionHandler(.success(result))
        }
    }
    
    func getLogsForProject(project: String, completionHandler: @escaping (Result<[LogInfoEntity], RequestError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if (project == "Project 1") {
                completionHandler(.success(testLogInfoModels))
            } else if (project == "Project 2") {
                completionHandler(.success(testLogInfoModels2))
            } else if (project == "Project 3") {
                completionHandler(.success(testLogInfoModels3))
            }
        }
    }

    func getLog(project: String, id: String, completionHandler: @escaping (Result<LogEntity, RequestError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let result = LogEntity(
                project: project, info: testLogInfoModels[0], data: LogContentEntity(id: "0", contents: "mock contents for " + id))
            completionHandler(.success(result))
        }
    }
}

let testLogInfoModels = [LogInfoEntity(id: "0", title: "title 1", author: "developer 1", createdAt: Date(), contentsId: "c1"),
                       LogInfoEntity(id: "1", title: "title 2", author: "developer 2", createdAt: Date(), contentsId: "c2"),
                       LogInfoEntity(id: "2", title: "title 2", author: "developer 2", createdAt: Date(), contentsId: "c2"),
                       LogInfoEntity(id: "3", title: "title 2", author: "developer 2", createdAt: Date(), contentsId: "c2"),
                       LogInfoEntity(id: "4", title: "title 2", author: "developer 2", createdAt: Date(), contentsId: "c2"),
                       LogInfoEntity(id: "5", title: "title 2", author: "developer 2", createdAt: Date(), contentsId: "c2"),
                       LogInfoEntity(id: "6", title: "title 2", author: "developer 2", createdAt: Date(), contentsId: "c2")]

let testLogInfoModels2 = [LogInfoEntity(id: "7", title: "title 3", author: "developer 4", createdAt: Date(), contentsId: "c3"),
                       LogInfoEntity(id: "8", title: "title 4", author: "developer 5", createdAt: Date(), contentsId: "c4")]

let testLogInfoModels3 = [LogInfoEntity(id: "9", title: "title 5", author: "developer 6", createdAt: Date(), contentsId: "c5"),
                       LogInfoEntity(id: "10", title: "title 6", author: "developer 7", createdAt: Date(), contentsId: "c6"),
                       LogInfoEntity(id: "11", title: "title 7", author: "developer 8", createdAt: Date(), contentsId: "c7")]
