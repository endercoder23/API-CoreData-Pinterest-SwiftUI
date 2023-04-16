//
//  ArticleInfo.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 16/04/23.
//

import SwiftUI

struct ArticleInfo: View {
    
    // MARK: Properties
    @State var showFullImage: Bool = false
    let article: Articles
    
    //MARK: Body
    var body: some View {
        VStack(spacing: 15) {
            let url = URL(string: article.urlToImage ?? "")
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, idealHeight: 150)
                    .onTapGesture {
                        showFullImage.toggle()
                    }
                    .fullScreenCover(isPresented: $showFullImage, content: {
                        ArticleImage(isPresent: $showFullImage, imageURL: url ?? URL(fileURLWithPath: ""))
                    })
            } placeholder: {
                Color.gray
                    .frame(maxWidth: .infinity, idealHeight: 150)
            }
            
            Text(article.title ?? "")
                .font(.title)
                .bold()
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
            
            VStack(alignment: .leading ,spacing: 10) {
                HStack {
                    Text(article.publishedAt ?? "")
                        .font(.caption)
                    Spacer()
                    
                    VStack(alignment: .leading ,spacing: 0) {
                        Text("Author")
                            .bold()
                            .font(.caption)
                        
                        Text(article.author ?? "")
                            .font(.caption)
                    } // VStack
                } // HStack
                .padding(10)
                
                VStack(spacing: 5) {
                    Text("Description")
                        .bold()
                    
                    Text(article.description ?? "")
                } // VStack
                .font(.subheadline)
                .frame(alignment: .leading)
                
                
                VStack(spacing: 5) {
                    Text("Content")
                        .bold()
                        .padding(.top, 10)
                    
                    Text(article.content ?? "")
                } // VStack
                .font(.subheadline)
                
                HStack(alignment: .center) {
                    Spacer()
                    Button("Show Full Article") {
                        if let url = URL(string: article.url ?? "") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                } // HStack
                .padding(.top, 10)
                
                Spacer()
            } // VStack
            .padding()
  
            Spacer()
        } // VStack
    }
}

