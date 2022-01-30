//
//  Student.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/30.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Foundation

struct Student: Codable{
    var kind: StudentKind
    var name: String
    var gender: Gender
    var birth: Date
    var school: School
    var email: String
}
