//
//  LottoAPIManager.swift
//  NetworkSesac
//
//  Created by 김재석 on 1/16/24.
//

import Foundation
import Alamofire

struct LottoAPIManager {
    
    func callRequest(round: String, completionHandler: @escaping (String) -> Void) {
        // round: 회차
        
        // 요청을 보내고 응답받는 시간에 레이턴시가 생긴다.
        // 따라서 viewDidLoad에서 사용한다하더라도 조금 늦게 뜨는 모습을 볼 수 있다.
        // Label이 먼저 살짝 보인 다음에 우리가 작성한 값이 보이게 된다.
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        // 내부에서 string -> url 변환 작업까지 포함되어 있다.
        // method 별도로 작성하지 않으면 default 값을 get으로 설정
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            switch response.result {
                // success: Lotto 구조체에 맞게 담겨서 나온 데이터
            case .success(let success):
                print(success)
                print(success.drwNoDate)
                
                // self 붙여줘야한다. AF 안에서 코드가 구성되고 있는데
                // dateLabel이 AF안에 있을 수도 있으니 self를 붙여줌으로써
                // 내가 만든 것임을 명시해 주는 것이라 생각하면 된다.
                
//                self.dateLabel.text = success.drwNoDate
                // 함수안에 또 함수를 쓰는거라 이스케이핑 클로저 필요
                completionHandler(success.drwNoDate)
            case .failure(let failure):
                print("ERROR")
            }
        }
    }
    
}
