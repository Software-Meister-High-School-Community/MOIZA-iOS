//
//  MoizaStep.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/24.
//  Copyright © 2022 com.connect. All rights reserved.
//

import RxFlow
import ReactorKit

enum MoizaStep: Step{
    // Global
    case alert(title: String?, message: String?)
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
    
    // Main
    case mainTabbarIsRequired
    case homeIsRequired
    case categoryIsRequired
    case alarmIsRequired
    case myPageIsRequired
    
    // Common
    case postDetailIsRequired
    case postDetailImageListIsRequired
    
    // Home
    
    // Posts
    case categoryDropdownIsRequired
    case searchIsRequired
    case searchResultIsRequired
    case searchSortIsRequired
    case postListIsRequired
    case postListSortIsRequired
    case postWriteIsRequired
    case temporarySavedPostIsRequired
    case answerIsRequired
    
    // Alarm
    case allNoticeListIsRequired
    
    // MyPage
    case followerIsRequired
    case followingIsRequired
    case myPostListSortIsRequired
    case myPageModifyIsRequired
    case myPageIntroduceModifyIsRequired
    case myPageWebsiteAddIsRequired
    case myPageSettingIsRequired
}
