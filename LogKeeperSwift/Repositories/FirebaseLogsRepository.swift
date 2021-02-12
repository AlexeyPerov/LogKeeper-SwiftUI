import Foundation

/*import Firebase
import FirebaseFirestoreSwift*/

class FirebaseLogsRepository: LogsRepository {
    func initialize() {
        //FirebaseApp.configure()
    }
    
    func getProjects(completionHandler: @escaping (Result<[String], RequestError>) -> Void) {
    }
    
    func getLogsForProject(project: String, completionHandler: @escaping (Result<[LogInfoEntity], RequestError>) -> Void) {

    }

    func getLog(project: String, id: String, completionHandler: @escaping (Result<LogEntity, RequestError>) -> Void) {

    }
}
