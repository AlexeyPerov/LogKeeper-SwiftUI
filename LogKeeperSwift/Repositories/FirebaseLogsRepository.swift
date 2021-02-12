import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseLogsRepository: LogsRepository {
    func initialize() {
        FirebaseApp.configure()
    }
        
    func getProjects(completionHandler: @escaping (Result<[String], RequestError>) -> Void) {
        let query = Firestore.firestore().collection("projects")
   
        query.addSnapshotListener {(snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching firestore: \(error!)")
                completionHandler(.success([]))
                return
            }
            let models = snapshot.documents.map { (document) -> String in
                return String(describing: document.data()["name"]!)
            }
            
            completionHandler(.success(models))
        }
    }
    
    func getLogsForProject(project: String, completionHandler: @escaping (Result<[LogInfoEntity], RequestError>) -> Void) {
        let collectionName = getProjectCollectionName(project: project)
        let query = Firestore.firestore().collection(collectionName)
        
        query.addSnapshotListener {(snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching firestore: \(error!)")
                completionHandler(.success([]))
                return
            }
            let models = snapshot.documents.map { (document) -> LogInfoEntity in
                let data = document.data()
                
                let timestamp: Timestamp = data["createdAt"] as! Timestamp
                let createdAt: Date = timestamp.dateValue()
                
                return LogInfoEntity(
                    id: document.documentID,
                    title: String(describing: data["title"]!),
                    author: String(describing: data["author"]!),
                    createdAt: createdAt,
                    contentsId: String(describing: data["contentsId"]!)
                )
            }
            
            completionHandler(.success(models))
        }
    }
    
    func getLog(project: String, id: String, completionHandler: @escaping (Result<LogEntity, RequestError>) -> Void) {
        let collectionName = getProjectCollectionName(project: project)
        let query = Firestore.firestore().collection(collectionName).document(id)
        
        query.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching firestore: \(error!)")
                completionHandler(.failure(.error(error: error!)))
                return
            }
                        
            let timestamp: Timestamp = snapshot.get("createdAt")! as! Timestamp
            let createdAt: Date = timestamp.dateValue()
            
            let contentsId = String(describing: snapshot.get("contentsId")!)
            
            let info = LogInfoEntity(
                id: snapshot.documentID,
                title: String(describing: snapshot.get("title")!),
                author: String(describing: snapshot.get("author")!),
                createdAt: createdAt,
                contentsId: contentsId
            )
            
            let contentsQuery = Firestore.firestore().collection("logs").document(contentsId)
            
            contentsQuery.addSnapshotListener { (contentSnapshot, error) in
                guard let contentSnapshot = contentSnapshot else {
                    print("Error fetching firestore: \(error!)")
                    completionHandler(.failure(.error(error: error!)))
                    return
                }
                
                let contents = LogContentEntity(
                    id: contentsId, contents: String(describing: contentSnapshot.get("contents") ?? "")
                )
                
                let result = LogEntity(
                    project: project, info: info, data: contents)
                completionHandler(.success(result))
            }
        }
    }
    
    func getAdminLink() -> String {
        return "https://console.firebase.google.com/u/2/project/" + (FirebaseApp.app()?.options.projectID)! + "/overview"
    }
    
    func getProjectCollectionName(project: String) -> String {
        let projectPrefix = project.replacingOccurrences(of: " ", with: "_").lowercased()
        return projectPrefix + "_logs"
    }
}
