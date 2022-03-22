import RxSwift

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}
    
    func login(req: LoginRequest, isTest: Bool) -> Completable {
        request(.login(req: req), isTest: isTest)
            .asCompletable()
    }
    func reissue(isTest: Bool) -> Completable {
        request(.reissue, isTest: isTest)
            .asCompletable()
    }
    func sendVerification(req: SendVerificationRequest, isTest: Bool) -> Completable {
        request(.sendVerification(req), isTest: isTest)
            .asCompletable()
    }
    func checkVerification(req: CheckVerificationRequest, isTest: Bool) -> Completable {
        request(.checkVerification(req), isTest: isTest)
            .asCompletable()
    }
    func checkIdValidation(id: String, isTest: Bool) -> Completable {
        request(.checkIdValidations(id: id), isTest: isTest)
            .asCompletable()
    }
    func findId(email: String, isTest: Bool) -> Single<FindIdResponse> {
        request(.findId(email: email), isTest: isTest)
            .map(FindIdResponse.self)
    }
    func changeNewPassword(
        newPassword: String,
        id: String,
        isTest: Bool
    ) -> Completable {
        request(.newPassword(password: newPassword, id: id), isTest: isTest)
            .asCompletable()
    }
}
