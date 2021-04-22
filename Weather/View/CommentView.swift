//
//  CommentView.swift
//  Weather
//
//  Created by Константин Лопаткин on 07.04.2021.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var vm: CommentViewModel
    @Environment(\.managedObjectContext) var moc
    @State var weather: Weather?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                TextEditor(text: $vm.text)
                    .frame(width: UIScreen.main.bounds.size.width, height: 200)
                    .border(Color.clear, width: 1)
                    .multilineTextAlignment(.leading)
                Spacer()
            }.padding(.all, 1)
            .background(Image("no")
                            .resizable()
                            .scaledToFill()
                            .opacity(0.8)
                            .ignoresSafeArea(.all))
            .navigationBarTitle("Comment", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button("Cancel"){
                                        vm.commentToggle.toggle()
                                    }.foregroundColor(Color(.cyan))
                                , trailing:
                                    //Save button //Update Button
                                    Button(action: {
                                        if vm.updateComment == nil {
                                            vm.saveComment(cityName: weather?.location?.name ?? "", moc: moc)
                                        } else { vm.updateComments(moc: moc) }
                                        vm.commentToggle.toggle()
                                    }){
                                        if vm.updateComment == nil{
                                            Text("Save")
                                        } else {
                                            Text("Update")
                                        }
                                    }.disabled((vm.updateComment?.text == vm.text || vm.text == "") ? true : false)
                                    .foregroundColor((vm.updateComment?.text == vm.text || vm.text == "") ? Color(.gray) : Color(.cyan)))
        }.colorScheme(.dark)
        
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(vm: CommentViewModel())
    }
}
