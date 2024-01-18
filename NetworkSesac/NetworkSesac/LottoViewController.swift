//
//  LottoViewController.swift
//  NetworkSesac
//
//  Created by 김재석 on 1/16/24.
//

import UIKit

// Codable 해 줘야한다
// Codable: Decodable, Encodable
struct Lotto: Codable {
    let drwNo: Int  // 회차
    let drwNoDate: String // 날짜
    
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController {

    @IBOutlet var roundTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    let apiManager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.callRequest(round: "1102") { value in
            self.dateLabel.text = value
        }
    }
    
    
    @IBAction func onReturnTapped(_ sender: UITextField) {
            
        // 아래와 같이 요청할 때 공백이거나 통신이 잘 안 될 수도 있음을 인지 요망
        apiManager.callRequest(round: roundTextField.text!) { value in
            self.dateLabel.text = value
        }
    }
}

    

