//
//  TopHeadlinesNews.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 15/04/23.
//

import SwiftUI

struct TopHeadlinesNews: View {
    
    // MARK: Properties
    @StateObject var viewModel = TopHeadlinesViewModel()
    var layout = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]
    
    // MARK: Body
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(viewModel.topHeadlines, id: \.id) { item in
                        NavigationLink(destination: ArticleInfo(article: item)) {
                            VStack(alignment: .leading,spacing: 8) {
                                let url = URL(string: item.urlToImage ?? "")
                                AsyncImage(url: url, content: { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                }) {
                                    Color.gray
                                }
                                
                                Text(item.description ?? "")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .padding(.horizontal, 5)
                                    .frame(maxHeight: .infinity)
                            } // VStack
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        } // NavigationLink
                    } // ForEach
                } // LazyVGrid
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            } // ScrollView
            .navigationTitle("Top Articles")
            .navigationBarTitleDisplayMode(.inline)
        } // Navigation
        .onAppear {
            viewModel.fetchTopHeadlines()
        }
    }
}

struct TopHeadlinesNews_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadlinesNews()
    }
}
