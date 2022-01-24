//
//  Inject.swift
//  CATest
//
//  Created by 최형우 on 2021/12/29.
//  Copyright © 2021 baegteun. All rights reserved.
//
import Swinject

@propertyWrapper
final class Inject<T>{
    let wrappedValue: T
    init(){
        wrappedValue = AppDelegate.container.resolve(T.self)!
    }
}

