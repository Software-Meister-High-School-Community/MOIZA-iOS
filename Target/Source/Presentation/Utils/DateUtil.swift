import Foundation

extension String {
    func toMoizaDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")!
        return formatter.date(from: self) ?? .init()
    }
    func toMoizaDateWithString() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.date(from: self) ?? .init()
    }
}

extension Date {
    func toMoizaDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .init(identifier: "UTC")
        return formatter.string(from: self)
    }
    func toMoizaDateWithTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = .init(identifier: "UTC")
        return formatter.string(from: self)
    }
}
