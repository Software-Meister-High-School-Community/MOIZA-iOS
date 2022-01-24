class TargetUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertEqual("A", "A")
    }

}
