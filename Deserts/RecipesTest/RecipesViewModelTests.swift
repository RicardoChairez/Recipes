//
//  RecipesViewModelTests.swift
//  RecipesTest
//
//  Created by Chip Chairez on 2/17/25.
//

import XCTest

@testable import Deserts

final class RecipesViewModelTests: XCTestCase {
    private var sut: RecipesViewModel!
    
    override func setUp() {
        super.setUp()
        sut = RecipesViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
        
    func testGetRecipes() async {
        await sut.getRecipes() {
            XCTAssert(self.sut.vmState == .loaded)
        }
    }
    
    func testDownloadImage() async {
        sut.recipePreviews = [RecipePreview(name: "Banana Pancakes", cuisine: "American", id: "f8b20884-1e54-4e72-a417-dabbc8d91f12", imageURLString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg")]
        await sut.downloadImage(sut.recipePreviews[0]) {
            XCTAssertNotNil(self.sut.recipePreviews[0].imageDataURL)
        }
    }
    
}
