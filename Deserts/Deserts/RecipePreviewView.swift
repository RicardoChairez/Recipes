//
//  MealPreviewView.swift
//  Deserts
//
//  Created by Chip Chairez on 8/6/24.
//

import SwiftUI

struct RecipePreviewView: View {
    let recipePreview: RecipePreview
    
    var body: some View {
        VStack(spacing: 8){
            AsyncImage(url: recipePreview.imageDataURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .frame(height: 125)
            .clipped()
                
            Text(recipePreview.name)
                .font(.headline)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .top, .trailing], 8)
            
            Spacer()
            
            Text(recipePreview.cuisine)
                .font(.subheadline)
                .fontWeight(.ultraLight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .bottom, .trailing], 8)
        }
        .frame(height: 235)
        .background(.card)
        .cornerRadius(20)
        .shadow(color: Color(.black.opacity(0.2)), radius: 4)
        .padding(.vertical, 8)
    }
}

#Preview {
    RecipePreviewView(recipePreview: RecipePreview(name: "Banana Pancakes", cuisine: "American", id: "1", imageURLString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"))
}
