//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Константин Лопаткин on 22.04.2021.
//

import Foundation
import CoreData

protocol CommentDBProtocol {
    func saveComment(cityName: String, moc: NSManagedObjectContext)
    func editComment(item: Comment)
    func updateComment(moc: NSManagedObjectContext)
    func deleteComment(offsets: IndexSet, from city: City, moc: NSManagedObjectContext)
}

class CommentViewModel: ObservableObject, CommentDBProtocol {
    
    @Published var text = ""
    @Published var commentToggle = false
    @Published var updateComments: Comment?
    
    // Save Comments functions
    func saveComment(cityName: String, moc: NSManagedObjectContext){
            let comment = Comment(context: moc)
            comment.text = text
            comment.city = City(context: moc)
            comment.city?.name = cityName
            comment.city?.comment = NSSet(object: comment)
            
            try? moc.save()
            text = ""
    }
    // Edit Comments functions
    func editComment(item: Comment) {
        updateComments = item
        text = updateComments?.text ?? ""
    }
    // Update Comments functions
    func updateComment(moc: NSManagedObjectContext) {
        if updateComments != nil {
            updateComments?.text = text
            try? moc.save()
            updateComments = nil
            text = ""
        }
    }
    // Delete Comments functions
    func deleteComment(offsets: IndexSet, from city: City, moc: NSManagedObjectContext) {
            for offset in offsets.sorted().reversed() {
                let commentToDelete = city.commentArray[offset]
                city.removeFromComment(commentToDelete)
                moc.delete(commentToDelete)
            }
            if moc.hasChanges {
                try? moc.save()
            }
        
    }
    
    
    
    
    
}
