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
    
    //Find
    case certIsRequired
}
