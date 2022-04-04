import RxSwift

final class ChangeNewPasswordUseCase {
    internal init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    func execute(req: ChangeNewPasswordRequest, isTest: Bool = false) -> Completable{
        authRepository.changeNewPassword(req: req, isTest: isTest)
    }
}
