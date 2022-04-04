import RxSwift

final class CheckIdValidationUseCase {
    internal init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    func execute(id: String, isTest: Bool = false) -> Completable {
        authRepository.checkIdValidation(id: id, isTest: isTest)
    }
}
