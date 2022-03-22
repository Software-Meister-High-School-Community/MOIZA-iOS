import RxSwift

final class LoginUseCase {
    internal init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    func execute(req: LoginRequest, isTest: Bool = false) -> Completable {
        authRepository.login(req: req, isTest: isTest)
    }
}
