//
//  ArticleImage.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 15/04/23.
//

import SwiftUI

struct ArticleImage: View {
    
    // MARK: properties
    @Binding var isPresent: Bool
    let imageURL: URL
    
    //MARK: Body
    var body: some View {
        ZStack {
            ZStack {
                Button(action: { isPresent.toggle() }) {
                    HStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    .frame(width: 90, height: 60)
                    .background(Color.white)
                }
                Spacer()
            } // ZStack
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: Alignment.topLeading
            )
            
            
            AsyncImage(url: imageURL, content: { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            }) {
                Color.gray
            }
        } // ZStack
    }
}

struct ArticleImage_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImage(isPresent: .constant(false), imageURL: URL(fileURLWithPath: ""))
    }
}
