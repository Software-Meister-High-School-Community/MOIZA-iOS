import RxSwift

final class SendVerificationUseCase {
    internal init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    func execute(req: SendVerificationRequest, isTest: Bool = false) -> Completable {
        authRepository.sendVerification(req: req, isTest: isTest)
    }
}
