//
//  CanteenCard.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import SwiftUI

struct CanteenCard: View {
    let meal: Meal
    var body: some View {
        VStack(alignment: .leading) {
//            Text(canteenInfo.name)
//                .font(.system(size: 22))
//                .fontWeight(.bold)
            
//            Rectangle()
//                .fill(Color.orange)
//                .frame(height: 2)
            
//            Text("Hauptspeisen")
//                .font(.system(size: 20))
//                .fontWeight(.bold)
            
                HStack {
                    Image(systemName: "tortoise")
                        .padding(.leading)
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 2)
                    Text(meal.title)
                        .padding(EdgeInsets(top: 12, leading: 5, bottom: 12, trailing: 5))
                        .font(.system(size: 14))
                    Spacer()
                }
                .background(Color(UIColor.tertiarySystemBackground))
//                .overlay(RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color.orange, lineWidth: 1.5))
        
                .cornerRadius(5)
                .padding(.bottom)
            
//            Text("Beilagen")
//                .font(.system(size: 20))
//                .fontWeight(.bold)
//
//            ForEach(canteenInfo.meals.filter({ meals in return meals.type == "Beilagen"})) { meal in
//                Text(meal.title)
//                    .padding(EdgeInsets(top: 4, leading: 5, bottom: 4, trailing: 5))
//                    .font(.system(size: 14))
//
//                if (true) {
//                    Rectangle()
//                        .fill(Color.gray)
//                        .frame(height: 0.5)
//                }
//            }
        }
    }
}

//struct CanteenCard_Previews: PreviewProvider {
//    static var previews: some View {
//        // CanteenCard(meal: nil)
//    }
//}
