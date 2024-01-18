//
//  CoinMarketViewController.swift
//  NetworkSesac
//
//  Created by 김재석 on 1/16/24.
//

import UIKit
import Alamofire

struct VirtualCurrency: Codable {
    let market: String
    let korean_name: String
    let english_name: String
}

class CoinMarketViewController: UIViewController {

    @IBOutlet var coinTableView: UITableView!

    var getListData: [VirtualCurrency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequest()
        configureView()

    }
    
    func getRequest() {
        
        let url = "https://api.upbit.com/v1/market/all"
        
        
        // api가 리스트에 담아줘서 []로 한 번 감싸줘야 함
        // statusCode: 유효성 검사를 내부적으로 200<= < 300으로 해 두고 있음
        // 하지만 개발하는 사람 입맛에 맞게 커스떰 할 수 있다.
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: [VirtualCurrency].self) {response in
//            response.response?.statusCode == 200 {
//                self.getListData = success
//            } 이렇게 디테일하게 갈 수도 있다.
            switch response.result {
            case .success(let success):
                self.getListData = success
                self.coinTableView.reloadData()
                
                // 빈 테이블 보여주기
                // 그동안 데이터 받아오기
                // 받아오고 리스트에 담아주기
                // reloadData()로 화면 업데이트 갱신 코드 필요한 이유!
            case .failure(let failure):
                print("ERROR")
            }
        }
    }
    
    func configureView() {
        coinTableView.delegate = self
        coinTableView.dataSource = self
    }
}

extension CoinMarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinMarketCell")!
        
        cell.textLabel?.text = getListData[indexPath.row].korean_name
        cell.detailTextLabel?.text = getListData[indexPath.row].market
        return cell
    }
    
    
}
