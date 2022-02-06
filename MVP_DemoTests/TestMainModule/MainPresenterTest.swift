//
//  MainPresenterTest.swift
//  MVP_DemoTests
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import XCTest
@testable import MVP_Demo


class MockView: MainViewProtocol {
    func success() {
        //
    }
    
    func failure(with error: Error) {
        //
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var comments: [Comment]!
    
    init() { }
    
    convenience init(comments: [Comment]?) {
        self.init()
        self.comments = comments
    }
    
    func fetchComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [:])
            completion(.failure(error))
        }
    }
}

class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()
    

    override func setUpWithError() throws {
        router = Router(navigationController: UINavigationController(), assemblyBuilder: AssemblyBuilder())
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        networkService = nil
        router = nil
    }

    func testGetSuccessComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Bar", body: "Baz")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService(comments: [comment])
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchComments: [Comment]?
        
        networkService.fetchComments { result in
            switch result {
            case .success(let comments):
                catchComments = comments
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        
        XCTAssertNotEqual(catchComments?.count, 0)
        XCTAssertEqual(catchComments?.count, comments.count)
    }
    
    func testGetFailureComments() {
        view = MockView()
        networkService = MockNetworkService(comments: nil)
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.fetchComments { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
    }
    
    
    
}
