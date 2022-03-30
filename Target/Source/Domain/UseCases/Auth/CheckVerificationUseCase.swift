import RxSwift

final class CheckVerificationUseCase {
    internal init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    func execute(req: CheckVerificationRequest, isTest: Bool = false) -> Completable {
        authRepository.checkVerification(req: req, isTest: isTest)
    }
}
