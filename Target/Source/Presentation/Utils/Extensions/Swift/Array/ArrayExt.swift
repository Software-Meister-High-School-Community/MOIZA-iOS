import Foundation

extension Array {
    func randomElements() -> [Element] {
        filter { _ in .random() }
    }
}
