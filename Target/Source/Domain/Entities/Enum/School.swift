public enum School: String, Codable, CaseIterable{
    case gsm = "GSM"
    case dgsm = "DGSW"
    case dsm = "DSM"
    case mirim = "NCMM"
    case bsm = "BSSM"
}

public extension School{
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
        }
    }
    var display: String {
        switch self {
        case .gsm: return "광주소프트웨어마이스터고"
        case .dsm: return "대덕소프트웨어마이스터고"
        case .dgsm: return "대구소프트웨어마이스터고"
        case .bsm: return "부산소프트웨어마이스터고"
        case .mirim: return "미림마이스터고"
        }
    }
}
