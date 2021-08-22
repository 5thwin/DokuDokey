//
//  FillQuizViewController.swift
//  DokuDokey
//
//  Created by 오승연 on 2021/08/07.
//

import UIKit

class FillQuizViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate{
    
    
    @IBOutlet weak var inputCollectionView: UICollectionView!
    var screenSize : CGRect!
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSize = self.view.frame
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //하위 뷰 콘텐츠의 상하좌우의 패딩을 줌
        layout.minimumInteritemSpacing = 1 //cell간의 최소 거리
        layout.minimumLineSpacing = 1 //행 간의 최소 거리
        //inputCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        inputCollectionView.frame =  CGRect(x: 0, y: 100, width: screenWidth, height: screenWidth )
        inputCollectionView.collectionViewLayout = layout
        inputCollectionView!.dataSource = self
        inputCollectionView!.delegate = self
        //inputCollectionView!.register(InputCollectionViewCell.self, forCellWithReuseIdentifier: "inputCell")
        
        self.view.addSubview(inputCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "inputCell", for: indexPath) as! InputCollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        let rowIndex = indexPath.row / 9
        let colomnIndex = indexPath.row % 9
        if (rowIndex/3 + colomnIndex/3) % 2 == 0{
            cell.layer.backgroundColor = UIColor.init(displayP3Red: 220/255, green: 233/255, blue: 246/255, alpha: 1).cgColor //셀의 색 설정
            cell.inputTextfield.backgroundColor = UIColor.init(displayP3Red: 220/255, green: 233/255, blue: 246/255, alpha: 1)
        }
        else{
            cell.layer.backgroundColor = UIColor.init(displayP3Red: 225/255, green: 238/255, blue: 251/255, alpha: 1).cgColor
            cell.inputTextfield.backgroundColor = UIColor.init(displayP3Red: 245/255, green: 248/255, blue: 251/255, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/9 - 1 , height: screenWidth/9 - 1); //cell들의 크기
    }
    
    //cell 내의 textfield 숫자 입력 후 터치를 통해 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func removeAllText(_ sender: Any) {
        for cell in self.inputCollectionView.visibleCells {
            guard let inputcell = cell as? InputCollectionViewCell else{return}
            if inputcell.inputTextfield.text != nil{
                inputcell.inputTextfield.text = ""
            }
        }
    }
    
    @IBAction func sendQuizForm(_ sender: Any) {
        guard let showOutputView = self.storyboard?.instantiateViewController(identifier: "ShowOutputVC") as? ShowOutputViewController else{return}
        
        showOutputView.recievedSudoku = Sudoku99(input: inputCollectionView)
        self.navigationController?.pushViewController(showOutputView, animated: true)
    }
}

class InputCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    @IBOutlet weak var inputTextfield: UITextField!
    //1~9에 속하지 않는 문자들의 charset
    let charsetExceptNumber = CharacterSet(charactersIn: "123456789").inverted
    
    //객체가 초기화(인스턴스화)된 후 호출되는 메서드 awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextfield.delegate = self
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = self.inputTextfield.text else {
            return false
        }
        if string.count > 0{ //입력모드에서만 실행
            guard string.rangeOfCharacter(from: charsetExceptNumber) == nil else{
                return false //입력된 문자중에 1~9이외의 문자가 들어오면 false
            }
        }
        let newLength = text.count + string.count - range.length
        return newLength <= 1
    }
}
