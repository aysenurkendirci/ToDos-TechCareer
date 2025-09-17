import FMDB

final class ToDosRepository {
    private let db: FMDatabase
    
    init() {
        let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = URL(fileURLWithPath: docs).appendingPathComponent(DBConst.fileName).path
        db = FMDatabase(path: path)
    }
    
    func save(name: String) async throws {
        db.open(); defer { db.close() } //komuttan sonra defer:direkt kapatma için
        try db.executeUpdate("INSERT INTO toDos (name) VALUES (?)", values: [name])
    }
    
    func update(id: Int, name: String) async throws {
        db.open(); defer { db.close() }
        try db.executeUpdate("UPDATE toDos SET name = ? WHERE id = ?", values: [name, id])
    }
    
    func delete(id: Int) async throws {
        db.open(); defer { db.close() }
        try db.executeUpdate("DELETE FROM toDos WHERE id = ?", values: [id])
    }
    //listeleme
    func loadToDos() async throws -> [ToDos] {
        db.open(); defer { db.close() }  //executeQuery okuma için
        let rs = try db.executeQuery("SELECT id, name FROM toDos ORDER BY id DESC", values: nil)
        var list: [ToDos] = []
        while rs.next() {
            let id   = Int(rs.int(forColumn: "id"))
            let name = rs.string(forColumn: "name") ?? ""
            list.append(ToDos(id: id, name: name))
        }
        return list
    }
    
    func search(_ text: String) async throws -> [ToDos] {
        db.open(); defer { db.close() }
        let rs = try db.executeQuery("SELECT id, name FROM toDos WHERE name LIKE ? ORDER BY id DESC",
                                     values: ["%\(text)%"])
        var list: [ToDos] = []
        while rs.next() {
            list.append(ToDos(id: Int(rs.int(forColumn: "id")),
                              name: rs.string(forColumn: "name") ?? ""))
        }
        return list
    }
}
