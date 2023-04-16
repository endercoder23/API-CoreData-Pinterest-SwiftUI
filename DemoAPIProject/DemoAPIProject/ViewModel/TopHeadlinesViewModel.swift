//
//  TopHeadlinesViewModel.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 15/04/23.
//

import Foundation
import Combine
import CoreData


class TopHeadlinesViewModel: ObservableObject {
    
    @Published var topHeadlines: [Articles] = []
    private var cancellables = Set<AnyCancellable>()
    private let persistenceController = PersistenceController.shared
    
    func fetchTopHeadlines() {
        TopHeadlineService.shared.getTopHeadlines()
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] headlines in
                guard let self = self else { return }
                guard let articles = headlines.articles else {return}
                self.topHeadlines = articles
                print(articles.count)
                self.saveToCoreData(articles)
            }
            .store(in: &cancellables)
    }
    
    private func saveToCoreData(_ articles: [Articles]) {
        let context = persistenceController.container.viewContext
        
        do {
            for article in articles {
                let request = NSFetchRequest<TopArticles>(entityName: "TopArticles")
                request.predicate = NSPredicate(format: "urlToPage == %@", article.url ?? "")
                let results = try context.fetch(request)
                if let existingEntity = results.first {
                    existingEntity.title = article.title
                    existingEntity.desc = article.description
                    existingEntity.publishedAt = article.publishedAt?.toDate()
                    existingEntity.imageUrl = article.urlToImage
                    existingEntity.urlToPage = article.url
                    existingEntity.author = article.author
                    existingEntity.content = article.content
                    existingEntity.id = article.id
                } else {
                    let contextEntity = NSEntityDescription.entity(forEntityName: "TopArticles", in: context)!
                    let entity = TopArticles(entity: contextEntity, insertInto: context)
                    entity.title = article.title
                    entity.desc = article.description
                    entity.publishedAt = article.publishedAt?.toDate()
                    entity.imageUrl = article.urlToImage
                    entity.urlToPage = article.url
                    entity.author = article.author
                    entity.content = article.content
                    entity.id = article.id
                }
            }
            try context.save()
        } catch {
            print("error saving data")
        }
    }
    
    func deleteAll() {
        let context = persistenceController.container.viewContext
        //write item type to itemType
        do {
            let fetchRequest = TopArticles.fetchRequest()
            let items = try? context.fetch(fetchRequest)
            for item in items ?? [] {
                context.delete(item)
            }
            try context.save()
        } catch {
            print("fail to delete the data")
        }
    }
}
