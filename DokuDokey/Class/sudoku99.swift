//
//  sudoku99.swift
//  DokuDokey
//
//  Created by 오승연 on 2021/08/13.
//

import UIKit

class Position {
    var y : Int
    var x : Int
    init (y : Int, x : Int){
        self.y = y
        self.x = x
    }
}
class Sudoku99 {
    var problem : [[Int]]
    var initializedNumber : [[Bool]]
    init() {
        problem = Array(repeating: Array(repeating: 0, count: 9), count: 9) //0으로 초기화된 9x9 스도쿠 문제
        initializedNumber = Array(repeating: Array(repeating: false, count: 9), count: 9) //false로 초기화
    }
    init(input : UICollectionView!){
        problem = Array(repeating: Array(repeating: 0, count: 9), count: 9) //0으로 초기화된 9x9
        initializedNumber = Array(repeating: Array(repeating: false, count: 9), count: 9)
        for (index, elem) in input.visibleCells.enumerated(){
            let cell = elem as! InputCollectionViewCell
            let content = cell.inputTextfield.text
            if let value = content {
                if ["1","2","3","4","5","6","7","8","9"].contains(value){
                    problem[index/9][index%9] = Int(value)!
                    initializedNumber[index/9][index%9] = true
                    continue
                }
            }
            problem[index/9][index%9] = 0
        }
    }
    
    func printSudoku(){
        self.problem.forEach{
            $0.forEach{
                print($0, terminator: " ")
            }
            print("")
        }
    }
    func checkInRow(pos : Position, num : Int) -> Bool{
        for i in 0..<9{
            if problem[pos.y][i] == num{
                return false
            }
        }
        return true
    }
    func checkInColoum(pos : Position, num : Int) -> Bool{
        for i in 0..<9{
            if problem[i][pos.x] == num{
                return false
            }
        }
        return true
    }
    func checkInBox(pos : Position, num : Int) -> Bool{
        let leftBound : Int = (pos.x / 3) * 3
        let upBound : Int = (pos.y / 3) * 3
        for yIndex in upBound..<upBound + 3{
            for xIndex in leftBound..<leftBound + 3{
                if problem[yIndex][xIndex] == num{
                    return false
                }
            }
        }
        return true
    }
    
    func findNextBlank(startPos : Position) -> Position{
        for xIndex in (startPos.x)..<9{
            if problem[startPos.y][xIndex] == 0{
                return Position(y: startPos.y, x: xIndex)
            }
        }
        for yIndex in (startPos.y+1)..<9{
            for xIndex in 0..<9{
                if problem[yIndex][xIndex] == 0{
                    return Position(y: yIndex, x: xIndex)
                }
            }
        }
        return Position(y: -1, x: -1)
    }
    func recursiveSolve(pos : Position) -> Bool{
        if pos.x == -1{
            return true
        }
        for number in 1...9{
            if checkInRow(pos: pos, num: number) && checkInColoum(pos: pos, num: number) && checkInBox(pos: pos, num: number){
                self.problem[pos.y][pos.x] = number
                if recursiveSolve(pos: findNextBlank(startPos: pos)){
                    return true
                }
            }
        }
        self.problem[pos.y][pos.x] = 0
        return false
    }
    func solveSudoku() -> Bool{
        let isSolved = recursiveSolve(pos: findNextBlank(startPos: Position(y: 0, x: 0)))
        if isSolved{
            printSudoku()
            return true
        }else{
            print("Invalid Problems")
            return false
        }
    }
}
