//
//  TopHeadlineWaterfallGrid.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 16/04/23.
//

import SwiftUI
import Combine

struct TopHeadlinesNewsWaterFallGrid: View {
    
    // MARK: Properties
    @StateObject var viewModel = TopHeadlinesViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TopArticles.entity(), sortDescriptors: []) var items: FetchedResults<TopArticles>
    
    // MARK: Body
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VMasonry(columns: 2, content: {
                    ForEach(items, id: \.id) { item in
                        NavigationLink(destination: ArticleDetails(article: item)) {
                            VStack(alignment: .leading,spacing: 8) {
                                let url = URL(string: item.imageUrl ?? "")
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
                                        .frame(maxWidth: .infinity, idealHeight: 50)
                                }
    
                                Text(item.desc ?? "")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 5)
                            } // VStack
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        } // Navigation Link
                    } // ForEach
                }) // Pinterest View
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            } // Scroll View
            .navigationTitle("Top Articles")
            .navigationBarTitleDisplayMode(.inline)
        } // Navigation
        .onAppear {
            viewModel.fetchTopHeadlines()
        }
    }
}

struct TopHeadlinesNewsWaterFallGrid_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadlinesNewsWaterFallGrid()
    }
}
