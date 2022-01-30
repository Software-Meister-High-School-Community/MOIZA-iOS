//
//  School.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/29.
//  Copyright © 2022 com.connect. All rights reserved.
//

enum School:String, Codable{
    case gsm = "광주소프트웨어마이스터고등학교"
    case dgsm = "대구소프트웨어마이스터고등학교"
    case dsm = "대덕소프트웨어마이스터고등학교"
    case mirim = "미림마이스터고등학교"
    case bsm = "부산소프트웨어마이스터고등학교"
    case none = "선택 없음"
}

extension School{
    func toDomain() -> String{
        switch self {
        case .gsm:
            return "gsm.hs.kr"
        case .dgsm:
            return "dgsw.hs.kr"
        case .dsm:
            return "dsm.hs.kr"
        case .mirim:
            return "e-mirim.hs.kr"
        case .bsm:
            return "bssm.hs.kr"
        case .none:
            return ""
        }
    }
}
