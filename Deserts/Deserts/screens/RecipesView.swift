//
//  ContentView.swift
//  Deserts
//
//  Created by Chip Chairez on 8/6/24.
//

import SwiftUI

struct RecipesView: View {
    @State private var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                if viewModel.vmState == .loaded{
                    if viewModel.recipePreviews.isEmpty {
                        Text("No recipes found")
                            .font(.caption)
                            .padding()
                    }
                    LazyVGrid(columns: viewModel.columns){
                        ForEach(viewModel.recipePreviews, id: \.id) { recipePreview in
                            NavigationLink(){
                                RecipeView(viewModel: RecipeViewModel(recipePreview: recipePreview))
                            }label: {
                                RecipePreviewView(recipePreview: recipePreview)
                                    .task{ await viewModel.downloadImage(recipePreview){}}
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .transition(.opacity)
                    .padding([.horizontal, .bottom])
                }
                else if viewModel.vmState == .loading{
                    ProgressView()
                        .padding()
                }
                else if viewModel.vmState == .loadFailed{
                    Button() {
                        Task {
                            await viewModel.getRecipes(){}
                        }
                    } label: {
                        Text("Retry")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
            }
            .navigationTitle("Recipes")
            .refreshable {
                await viewModel.getRecipes(){}
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Could not load recipes."),
                message: Text("Please try again later.")
            )
        }
        .task {
            await viewModel.getRecipes(){}
        }
    }
}

#Preview {
    RecipesView()
}
