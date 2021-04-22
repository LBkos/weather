//
//  CommentView.swift
//  Weather
//
//  Created by Константин Лопаткин on 07.04.2021.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentVM: CommentViewModel
    @Environment(\.managedObjectContext) var moc
    @State var weather: Weather?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                TextEditor(text: $commentVM.text)
                    .frame(height: 200)
                    .border(Color.clear, width: 1)
                    .multilineTextAlignment(.leading)
                Spacer()
            }.padding(.top, 1)
            .background(Image("no")
                            .resizable()
                            .scaledToFill()
                            .opacity(0.8)
                            .ignoresSafeArea(.all))
            .navigationBarTitle("Comment", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button("Cancel"){
                                        commentVM.commentToggle.toggle()
                                    }.foregroundColor(Color(.cyan))
                                , trailing:
                                    //Save button //Update Button
                                    Button(action: {
                                        if commentVM.updateComments == nil {
                                            commentVM.saveComment(cityName: weather?.location?.name ?? "", moc: moc)
                                        } else { commentVM.updateComment(moc: moc) }
                                        commentVM.commentToggle.toggle()
                                    }){
                                        if commentVM.updateComments == nil{
                                            Text("Save")
                                        } else {
                                            Text("Update")
                                        }
                                    }.disabled((commentVM.updateComments?.text == commentVM.text || commentVM.text == "") ? true : false)
                                    .foregroundColor((commentVM.updateComments?.text == commentVM.text || commentVM.text == "") ? Color(.gray) : Color(.cyan)))
        }.colorScheme(.dark)
        
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(commentVM: CommentViewModel())
    }
}
