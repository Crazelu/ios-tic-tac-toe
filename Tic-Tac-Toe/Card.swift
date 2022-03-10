//
//  Card.swift
//  Tic-Tac-Toe
//
//  Created by Crazelu on 10/03/2022.
//

import SwiftUI

struct Card: View {
    var image:String
    var borderColor:Color = Color.black
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 90, height: 90)
            .aspectRatio(1, contentMode: .fit)
            .padding(10)
            .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(borderColor, lineWidth:7)
            )
            .cornerRadius(20)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(image: "x")
    }
}
