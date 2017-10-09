//
//  CoordinatorSampleTests.swift
//  CoordinatorSampleTests
//
//  Created by Peter Su on 24/09/2017.
//  Copyright © 2017 fenroar. All rights reserved.
//

import XCTest
import RxSwift
@testable import CoordinatorSample

class TestViewModelFactory: RegistrationFactory {
    
    var splashViewModel = SplashViewModel(delegate: .none)
    var loginViewModel = LoginViewModel(delegate: .none)
    var registerEmailViewModel = RegisterEmailViewModel(delegate: .none)
    var registerUsernameViewModel = RegisterUsernameViewModel(delegate: .none)
    
    func buildSplashViewModel(delegate: RegistrationCoordinatorDelegate) -> SplashViewModel {
        splashViewModel.delegate = delegate
        return splashViewModel
    }
    
    func buildLoginViewModel(delegate: RegistrationCoordinatorDelegate) -> LoginViewModel {
        loginViewModel.delegate = delegate
        return loginViewModel
    }
    
    func buildRegisterEmailViewModel(delegate: RegistrationCoordinatorDelegate) -> RegisterEmailViewModel {
        registerEmailViewModel.delegate = delegate
        return registerEmailViewModel
    }
    
    func buildRegisterUsernameViewModel(delegate: RegistrationCoordinatorDelegate) -> RegisterUsernameViewModel {
        registerUsernameViewModel.delegate = delegate
        return registerUsernameViewModel
    }
}

class CoordinatorSampleTests: XCTestCase {
    
    var viewModelFactory = TestViewModelFactory()
    var testWindow = TestWindow()
    var registrationCoordinator: RegistrationCoordinator?
    
    func testLogin() {
        
        let wireframeFactory = TestWireframeFactory()
        let viewModelFactory = TestViewModelFactory()
        let dependency = RegistrationDependency(wireframeFactory: wireframeFactory, viewModelFactory: viewModelFactory)
        registrationCoordinator = RegistrationCoordinator(window: testWindow, dependency: dependency)
        registrationCoordinator?.start()
        
        viewModelFactory.splashViewModel.action.onNext(.login)
        
        // Should be on login screen
        XCTAssertEqual(wireframeFactory.wireframe.viewControllers.count, 2)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers[0] is SplashViewController)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers[1] is LoginViewController)
        viewModelFactory.loginViewModel.email.value = "sample@email.com"
        viewModelFactory.loginViewModel.password.value = "password"
        viewModelFactory.loginViewModel.action.onNext(.login)
        
        // Expect view to be main screen
        XCTAssertEqual(wireframeFactory.wireframe.viewControllers.count, 1)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers.first is MainViewController)
    }
    
    func testRegistration() {
        
        let wireframeFactory = TestWireframeFactory()
        let viewModelFactory = TestViewModelFactory()
        let dependency = RegistrationDependency(wireframeFactory: wireframeFactory, viewModelFactory: viewModelFactory)
        registrationCoordinator = RegistrationCoordinator(window: testWindow, dependency: dependency)
        registrationCoordinator?.start()
        
        viewModelFactory.splashViewModel.action.onNext(.register)
        
        // Should be on register username screen
        XCTAssertEqual(wireframeFactory.wireframe.viewControllers.count, 2)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers[0] is SplashViewController)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers[1] is RegisterUsernameViewController)
        viewModelFactory.registerUsernameViewModel.username.value = "my_user_name"
        viewModelFactory.registerUsernameViewModel.action.onNext(.register)
        
        // Should be on register email screen
        XCTAssertEqual(wireframeFactory.wireframe.viewControllers.count, 3)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers[0] is SplashViewController)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers[1] is RegisterUsernameViewController)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers[2] is RegisterEmailViewController)
        viewModelFactory.registerEmailViewModel.email.value = "sample@email.com"
        viewModelFactory.registerEmailViewModel.password.value = "password"
        viewModelFactory.registerEmailViewModel.action.onNext(.register)
        
        // Expect view to be main screen
        XCTAssertEqual(wireframeFactory.wireframe.viewControllers.count, 1)
        XCTAssertTrue(wireframeFactory.wireframe.viewControllers.first is MainViewController)
    }
}
