import RxSwift

final class DefaultAuthRepository: AuthRepository {
    private let authRemote = AuthRemote.shared
    func login(req: LoginRequest, isTest: Bool) -> Completable {
        authRemote.login(req: req, isTest: isTest)
    }
    func sendVerification(req: SendVerificationRequest, isTest: Bool) -> Completable {
        authRemote.sendVerification(req: req, isTest: isTest)
    }
    func checkVerification(req: CheckVerificationRequest, isTest: Bool) -> Completable {
        authRemote.checkVerification(req: req, isTest: isTest)
    }
    func checkIdValidation(id: String, isTest: Bool) -> Completable {
        authRemote.checkIdValidation(id: id, isTest: isTest)
    }
    func findId(email: String, isTest: Bool) -> Single<FindIdResponse> {
        authRemote.findId(email: email, isTest: isTest)
    }
    func changeNewPassword(req: ChangeNewPasswordRequest, isTest: Bool) -> Completable {
        authRemote.changeNewPassword(req: req, isTest: isTest)
    }
    func reissue(isTest: Bool) -> Completable {
        authRemote.reissue(isTest: isTest)
    }
}
