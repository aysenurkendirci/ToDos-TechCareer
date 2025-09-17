
import Foundation

struct ToDos: Identifiable {
    var id: Int?
    var name: String
    
    init(id: Int? = nil, name: String = "") {
        self.id = id
        self.name = name
    }
}
