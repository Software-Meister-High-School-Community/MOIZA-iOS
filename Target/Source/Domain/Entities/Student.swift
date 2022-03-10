import Foundation

struct Student: Codable{
    var scope: UserScope
    var name: String
    var gender: Gender
    var birth: Date
    var school: School
    var email: String
}
