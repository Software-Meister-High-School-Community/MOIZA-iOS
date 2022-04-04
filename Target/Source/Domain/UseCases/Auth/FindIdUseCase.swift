import RxSwift

final class FindIdUseCase {
    internal init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    func execute(email: String, isTest: Bool = false) -> Single<FindIdResponse>{
        authRepository.findId(email: email, isTest: isTest)
    }
}
