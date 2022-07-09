//
//  MoizaStep.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow
import ReactorKit
import RxSwift
import RxRelay

enum MoizaStep: Step{
    // Global
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case errorAlert(title: String?, message: String?)
    case dismiss
    
    // OnBoarding
    case onBoardingIsRequired
    
    // Auth
    case signInIsRequired
    case signUpIsRequired
    case findingIDIsRequired
    case findingPasswordIsRequired
    
    // SignUp
    case signUpInformationIsRequired
    case signUpLoginSetupIsRequired(Student)
    case signUpSuccessIsRequired
    case signUpIsCompleted
    case signUpGraduateAuthIsRequired
    case signUpGraduateAuthFileIsRequired
    case signUpGraduateAuthSuccessIsRequired
    case signUpGraduateAuthIsCompleted
    
    //Find
    case certIsRequired
    case successFindIDRequired
    case sendCertRequired(String)
    case reRegistorRequired
    case successFindPWRequired
    case findingPWIsCompleted
    
    // Main
    case mainTabbarIsRequired
    case homeIsRequired
    case categoryIsRequired
    case alarmIsRequired
    case myPageIsRequired
    
    // Common
    case sortIsRequired(_ options: [SortOption], initial: (PostType, SortType), onComplete: ((PostType, SortType, Major) -> Void))
    case majorSelectIsRequired
    case postDetailIsRequired(Int)
    case postDetailImageListIsRequired
    
    // Home
    
    // Posts
    case categoryDropdownIsRequired
    case searchIsRequired
    case searchResultIsRequired
    case postListIsRequired
    case postWriteIsRequired
    case temporarySavedPostIsRequired
    case answerIsRequired
    
    // Alarm
    case allNoticeListIsRequired
    
    // MyPage
    case followerIsRequired
    case myPageModifyIsRequired
    case myPageIntroduceModifyIsRequired
    case myPageWebsiteAddIsRequired
    case myPageSettingIsRequired
    case myPostListSortIsRequired
}
