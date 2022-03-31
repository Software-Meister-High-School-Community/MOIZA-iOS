import Foundation

struct Student: Codable{
    var scope: UserScope
    var name: String
    var gender: Gender
    var birth: Date
    var school: School
    var email: String
}

extension Student {
    static let dummy = Student(
        scope: .allCases.randomElement(),
        name: "김이름",
        gender: .allCases.randomElement(),
        birth: Date(),
        school: .allCases.randomElement(),
        email: "email@gmail.com"
    )
}
