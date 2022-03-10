//
//  CardRow.swift
//  Tic-Tac-Toe
//
//  Created by Crazelu on 10/03/2022.
//

import SwiftUI

func onTapPrev(x: Int, y: Int)-> Void{}

struct CardRow: View {
    var slots:[Slot]
    var index:Int
    var onTap:(Int, Int)->Void
    
    var body: some View {
        HStack{
            ForEach(slots, id: \.self.index){
            slot in
                Button(action: {
                    onTap(index, slot.index)
                }){
                    Card(
                        image: slot.image,
                        borderColor: slot.borderColor
                    )
                }
             
              
            }
        }
      
    }
}


struct CardRow_Previews: PreviewProvider {
  
    
    static var previews: some View {
        CardRow(slots: [Slot(image: "x", index: 0)],index:0, onTap: onTapPrev)
    }
}
