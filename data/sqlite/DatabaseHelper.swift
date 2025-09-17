
import Foundation

enum DBConst {
    static let nameNoExt = "todos_app"
    static let fileName  = "todos_app.sqlite"
}

final class DatabaseHelper {
    static func copyDatabase() {
        let fm = FileManager.default

        guard let srcURL = Bundle.main.url(forResource: DBConst.nameNoExt, withExtension: "sqlite") else {
            print(" Bundle’da \(DBConst.fileName) bulunamadı")
            return
        }

        let docs = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let dstURL = docs.appendingPathComponent(DBConst.fileName)

        if !fm.fileExists(atPath: dstURL.path) {
            do {
                try fm.copyItem(at: srcURL, to: dstURL)
                print(" DB kopyalandı → \(dstURL.path)")
            } catch {
                print(" DB kopyalama hatası: \(error)")
            }
        } else {
            print(" DB zaten var → \(dstURL.path)")
        }
    }
}
