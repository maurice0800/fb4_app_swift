//
//  SearchBox.swift
//  fb4app
//
//  Created by Maurice Hennig on 03.04.23.
//

import SwiftUI

struct SearchBox: View {
    @Binding var text: String
    @Binding var isVisible: Bool
    @FocusState private var isFocused: Bool
    
    @State private var isEditing = false
    
    var body: some View {
            HStack {
     
                TextField("Suchen ...", text: $text)
                    .padding(7)
                    .focused($isFocused)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                     
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .onAppear {
                        isFocused = true
                    }
     
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.isVisible = false
                        self.text = ""
     
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
            }
        }
}

//struct SearchBox_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBox()
//    }
//}
