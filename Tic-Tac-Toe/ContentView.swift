//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Crazelu on 10/03/2022.
//

import SwiftUI

struct Slot:Hashable{
    var image:String = ""
    var index:Int
    var borderColor:Color = Color.black
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(index)
           hasher.combine(image)
        hasher.combine(borderColor)
       }
}

struct ContentView: View {
    @State private var slotList = [
        [Slot(index: 0),Slot(index: 1),Slot(index: 2)],
        [Slot(index: 0),Slot(index: 1),Slot(index: 2)],
        [Slot(index: 0),Slot(index: 1),Slot(index: 2)]
    ]
    @State private var isXTurn = true
    @State private var moveCount:Int = 0
    @State private var isWon:Bool = false
    @State private var buttonText:String = ""
    
    private func reset() -> Void{
        self.buttonText = ""
        self.isXTurn = true
        self.isWon = false
        self.moveCount = 0
        self.slotList = [
            [Slot(index: 0),Slot(index: 1),Slot(index: 2)],
            [Slot(index: 0),Slot(index: 1),Slot(index: 2)],
            [Slot(index: 0),Slot(index: 1),Slot(index: 2)]
        ]
    }
    
    private func play (x:Int, y:Int) -> Void{
        if(isWon || self.moveCount==9) {return}
            
        if(isXTurn){
            self.slotList[x][y].image = "x"
        }else{
            self.slotList[x][y].image = "o"
        }
        isXTurn.toggle()
        self.moveCount+=1
        self.buttonText = "Reset"
        evaluateWin()
    }
    
    private func declareWinner()-> Void{
        self.isWon = true
        if(self.isXTurn){
            self.buttonText = "O won!\nPlay again"
        }else{
            self.buttonText = "X won!\nPlay again"
        }
    }
    
    private func evaluateWin()-> Void{
        //need at least 5 moves to have a winner
        if(self.moveCount>=5){
            //first row
            if(self.slotList[0].allSatisfy{!$0.image.isEmpty && $0.image == self.slotList[0][0].image }){
                self.slotList[0] =  self.slotList[0].map{(slot)-> Slot in Slot( image: slot.image, index:slot.index,  borderColor: Color.red)}
                    declareWinner()
                }
            //second row
               else if(self.slotList[1].allSatisfy{!$0.image.isEmpty && $0.image == self.slotList[1][0].image }){
                   self.slotList[1] =  self.slotList[1].map{(slot)-> Slot in Slot( image: slot.image, index:slot.index,  borderColor: Color.red)}
                    declareWinner()
                }
            //third row
               else if(self.slotList[2].allSatisfy{!$0.image.isEmpty && $0.image == self.slotList[2][0].image }){
                   self.slotList[2] =  self.slotList[2].map{(slot)-> Slot in Slot( image: slot.image, index:slot.index,  borderColor: Color.red)}
                    declareWinner()
                }
            //first columnn
            else if(!self.slotList[0][0].image.isEmpty && self.slotList[0][0].image == self.slotList[1][0].image && self.slotList[1][0].image == self.slotList[2][0].image){
                for i in 0...2{
                    self.slotList[i][0].borderColor = Color.red
                }
                    declareWinner()
                }
            //second columnn
            else if(!self.slotList[0][1].image.isEmpty && self.slotList[0][1].image == self.slotList[1][1].image && self.slotList[1][1].image == self.slotList[2][1].image){
                for i in 0...2{
                    self.slotList[i][1].borderColor = Color.red
                }
                    declareWinner()
                }
            //third columnn
            else if(!self.slotList[0][2].image.isEmpty && self.slotList[0][2].image == self.slotList[1][2].image && self.slotList[1][2].image == self.slotList[2][2].image){
                for i in 0...2{
                    self.slotList[i][2].borderColor = Color.red
                }
                    declareWinner()
                }
            //left to right diagonal
            else if(!self.slotList[0][0].image.isEmpty && self.slotList[0][0].image == self.slotList[1][1].image && self.slotList[1][1].image == self.slotList[2][2].image){
                for i in 0...2{
                    self.slotList[i][i].borderColor = Color.red
                }
                    declareWinner()
                }
            //right to left diagonal
            else if(!self.slotList[0][2].image.isEmpty && self.slotList[0][2].image == self.slotList[1][1].image && self.slotList[1][1].image == self.slotList[2][0].image){
                for i in 0...2{
                    self.slotList[i][2-i].borderColor = Color.red
                }
                    declareWinner()
                }
        }
        if(!isWon && self.moveCount==9) {
            self.buttonText = "No winner!\nPlay again"
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            ForEach(0...2, id: \.self){
                i in
               CardRow(
                slots: self.slotList[i],
                index: i,
                onTap: play
               )
            }
           Spacer()
            if(!buttonText.isEmpty){
                Button(
                    action: {
                        reset()
                    },
                     label: {
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding(.horizontal, 30)
                            .background(Color.pink)
                            .cornerRadius(20)
                    })
            }
            
            Spacer()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
