//
//  DesertsViewModel.swift
//  Deserts
//
//  Created by Chip Chairez on 8/7/24.
//

import Foundation
import SwiftUI

struct RecipePreviewsResponse: Codable {
    var recipes: [RecipePreview]
}
enum RecipesViewStates {
    case loading, loaded, loadFailed, notLoaded
}

@Observable
class RecipesViewModel{
    let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]
    var recipePreviews: [RecipePreview] = []
    var showAlert = false
    var vmState: RecipesViewStates = .notLoaded
    private let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    func getRecipes(completion: @escaping () -> Void) async {
        vmState = .loading
        APIManager.shared.request(modelType: RecipePreviewsResponse.self, url: URL(string: urlString)) { result in
            switch result {
            case .success(let decodedResponse):
                let recipePreviewsCopy = self.recipePreviews
                self.recipePreviews = decodedResponse.recipes.sorted(by: {$0.cuisine < $1.cuisine})
                for i in 0..<recipePreviewsCopy.count {
                    if let index = self.recipePreviews.firstIndex(where: {$0.id == self.recipePreviews[i].id}) {
                        self.recipePreviews[index].imageDataURL = recipePreviewsCopy[i].imageDataURL
                    }
                }
                self.vmState = .loaded
                
            case .failure(let error):
                print(error)
                self.showAlert = true
                return
            }
        }
        vmState = .loaded
    }
    
    func downloadImage(_ recipePreview: RecipePreview, completion: @escaping () -> Void) async {
        guard let index = recipePreviews.firstIndex(where: {$0.id == recipePreview.id}), recipePreviews[index].imageDataURL == nil, recipePreview.imageURL != nil else {
            return
        }
        APIManager.shared.downloadImageDataURL(url: recipePreview.imageURL) { result in
            switch result {
            case .success(let imageDataURL):
                self.recipePreviews[index].imageDataURL = imageDataURL
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
