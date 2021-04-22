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
    func updateComments(moc: NSManagedObjectContext)
    func deleteComment(offsets: IndexSet, from city: City, moc: NSManagedObjectContext)
}

class CommentViewModel: ObservableObject, CommentDBProtocol {
    
    @Published var text = ""
    @Published var commentToggle = false
    @Published var updateComment: Comment?
    
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
        updateComment = item
        text = updateComment?.text ?? ""
    }
    // Update Comments functions
    func updateComments(moc: NSManagedObjectContext) {
        if updateComment != nil {
            updateComment?.text = text
            try? moc.save()
            updateComment = nil
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
            if moc.hasChanges{ try? moc.save() }
        
    }
    
    
    
    
    
}
