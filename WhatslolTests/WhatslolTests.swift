//
//  WhatslolTests.swift
//  WhatslolTests
//
//  Created by Hélio Mesquita on 01/11/22.
//

import XCTest
@testable import Whatslol

class DummyViewController: ChatsViewModelProtocol {
    
    var isCalledReloadData = false
    
    func reloadData() {
        isCalledReloadData = true
    }
    
}

class MockNetworkService<X: Decodable>: NetworkServiceProtocol {
    
    var success: Bool = true
    var mockedData: X
    
    init(mockedData: X) {
        self.mockedData = mockedData
    }
    
    func performRequest<X>(
        url: URL, responseModel: X.Type,
        onSuccess: @escaping (X) -> Void,
        onFailure: @escaping (Error) -> ()) where X : Decodable {
            if success {
                onSuccess(mockedData as! X)
            } else {
                onFailure(NSError(domain: "fake error", code: 0, userInfo: nil))
            }
    }
    
}

class ChatsViewModelTests: XCTestCase {
    
    var dummyViewController = DummyViewController()
    let mockChats = [
        ChatResponse(profileImage: URL(string: "www.google.com.br")!, name: "tanto faz", lastMessage: "tanto faz", hasVisualized: true, lastMessageDate: "tanto faz", profile: URL(string: "www.google.com.br")!)
    ]
    lazy var mockNetwork = MockNetworkService<[ChatResponse]>(mockedData: mockChats)
    lazy var objectUnderTest = ChatsViewModel(delegate: dummyViewController, network: mockNetwork)
    
    
    override func setUp() {
        
    }

    func testLoadScreenOnSuccess() throws {
        objectUnderTest.loadScreen()
        XCTAssertEqual(objectUnderTest.numberOfRowsInSection(), 1)
        XCTAssertTrue(dummyViewController.isCalledReloadData)
        XCTAssertEqual(objectUnderTest.chatForIndexPath(indexPath: IndexPath(item: 0, section: 0)).name, "tanto faz")
    }
    
    func testLoadScreenOnFailure() throws {
        mockNetwork.success = false
        objectUnderTest.loadScreen()
        XCTAssertEqual(objectUnderTest.numberOfRowsInSection(), 0)
        XCTAssertTrue(dummyViewController.isCalledReloadData)
    }

}
