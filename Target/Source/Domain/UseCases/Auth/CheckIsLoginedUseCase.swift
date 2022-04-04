import RxSwift

final class CheckIsLoginedUseCase {
    internal init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    func execute(isTest: Bool = false) -> Completable {
        authRepository.reissue(isTest: isTest)
    }
}
