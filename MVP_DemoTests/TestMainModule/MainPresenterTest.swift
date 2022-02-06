//
//  MainPresenterTest.swift
//  MVP_DemoTests
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import XCTest
@testable import MVP_Demo

class MockView: MainViewProtocol {
    var testTitle: String?
    func setGreeting(greeting: String) {
        testTitle = greeting
    }
}

class MainPresenterTest: XCTestCase {
    
    var view: MainViewProtocol!
    var person: Person!
    var presenter: MainPresenter!

    override func setUpWithError() throws {
        view = MockView()
        person = Person(firstName: "Foo", lastName: "Bar")
        presenter = MainPresenter(view: view, person: person)
    }

    override func tearDownWithError() throws {
        view = nil
        person = nil
        presenter = nil
    }

    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "View is nil")
        XCTAssertNotNil(person, "Person is nil")
        XCTAssertNotNil(presenter, "Presenter is nil")
    }
    
    func testPersonModel() {
        XCTAssertEqual(person.firstName, "Foo")
        XCTAssertEqual(person.lastName, "Bar")
    }
    
    func testView() {
        presenter.showGreeting()
        XCTAssertEqual((view as! MockView).testTitle, "Hello, Bar Foo!")
    }
    
}
