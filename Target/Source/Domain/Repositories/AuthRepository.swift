import RxSwift

protocol AuthRepository {
    func login(req: LoginRequest, isTest: Bool) -> Completable
    func sendVerification(req: SendVerificationRequest, isTest: Bool) -> Completable
    func checkVerification(req: CheckVerificationRequest, isTest: Bool) -> Completable
    func checkIdValidation(id: String, isTest: Bool) -> Completable
    func findId(email: String, isTest: Bool) -> Single<FindIdResponse>
    func changeNewPassword(req: ChangeNewPasswordRequest, isTest: Bool) -> Completable
    func reissue(isTest: Bool) -> Completable
}
