//
//  ViewController.swift
//  NetworkSesac
//
//  Created by 김재석 on 1/16/24.
//

import UIKit
import Alamofire

/*
 고려할 사항
 1. 네트워크 통신 단절 상태
 2. API 콜 수 제한 초과
 3. 필요 이상의 과한 호출 -> 연속 클릭 방지 기능, 텍스트 비교 후 같은 글자면 요청 안 하기
 4. loadingView, progressingBar ...
 5. 두 음절 이상
 */

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapagoFinal
}

struct PapagoFinal: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}

class ViewController: UIViewController {

    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var targetLabel: UILabel!
    
    @IBOutlet var translateButton: UIButton!
    
    @IBOutlet var sourceButton: UIButton!
    @IBOutlet var targetButton: UIButton!
    @IBOutlet var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }
    
    @IBAction func sourceButtonOnClick(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func targetButtonOnClick(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func translateButtonClicked() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        // type을 명시해서 일치시켜준다.
        let parameter: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        
        // form에 넣는 데이터 parameter자리에 dict으로 담아준다.
        // self쓰는 이유: 메서드 내 똑같은 이름의 변수가 있을 수 있으니
        // 클래스에서 쓰는 것이라고 표현하는 것이라고 생각하면 된다.
        AF.request(
            url,
            method: .post,
            parameters: parameter,
            headers: headers
        ).responseDecodable(of: Papago.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                self.targetLabel.text = success.message.result.translatedText
            case .failure(let failure):
                print(failure)
            }
        }
    }

}

