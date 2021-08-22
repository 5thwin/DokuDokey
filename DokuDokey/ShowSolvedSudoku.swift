//
//  ShowSolvedSudoku.swift
//  DokuDokey
//
//  Created by 오승연 on 2021/08/16.
//

import UIKit

class ShowOutputViewController : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    @IBOutlet weak var outputCollectionView: UICollectionView!
    var recievedSudoku = Sudoku99()
    var screenSize : CGRect!
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    var isSolved : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSize = self.view.frame
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        isSolved = recievedSudoku.solveSudoku()
        outputCollectionView!.delegate = self
        outputCollectionView!.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "outputCell", for: indexPath) as! OutputCollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.backgroundColor = UIColor.init(displayP3Red: 220/255, green: 233/255, blue: 246/255, alpha: 1).cgColor //셀의 색 설정
        cell.outputLabel.text = String(recievedSudoku.problem[indexPath.row/9][indexPath.row%9])
        let rowIndex = indexPath.row / 9
        let colomnIndex = indexPath.row % 9
        if (rowIndex/3 + colomnIndex/3) % 2 == 0{
            cell.layer.backgroundColor = UIColor.init(displayP3Red: 220/255, green: 233/255, blue: 246/255, alpha: 1).cgColor //셀의 색 설정
            cell.outputLabel.backgroundColor = UIColor.init(displayP3Red: 220/255, green: 233/255, blue: 246/255, alpha: 1)
        }
        else{
            cell.layer.backgroundColor = UIColor.init(displayP3Red: 225/255, green: 238/255, blue: 251/255, alpha: 1).cgColor
            cell.outputLabel.backgroundColor = UIColor.init(displayP3Red: 245/255, green: 248/255, blue: 251/255, alpha: 1)
        }
        if recievedSudoku.initializedNumber[indexPath.row/9][indexPath.row%9] { //초기에 입력된 값이면
            cell.outputLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/9 - 1 , height: screenWidth/9 - 1); //cell들의 크기
    }
}

class OutputCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var outputLabel: UILabel!
    //객체가 초기화(인스턴스화)된 후 호출되는 메서드 awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        outputLabel.textAlignment = .center
    }
}
