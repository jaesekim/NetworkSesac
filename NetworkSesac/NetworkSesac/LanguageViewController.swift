//
//  LanguageViewController.swift
//  NetworkSesac
//
//  Created by 김재석 on 1/18/24.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet var backButton: UIButton!
    @IBOutlet var langTableView: UITableView!
    
    let codeDict = [
        "ko": "한국어",
        "en": "영어",
        "ja": "일본어",
        "zh-CN": "중국어 간체",
        "zh-TW": "중국어 번체",
        "vi": "베트남어",
        "id": "인도네시아어",
        "th": "태국어",
        "de": "독일어",
        "ru": "러시아어",
        "es": "스페인어",
        "it": "이탈리아어",
        "fr": "프랑스어",
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

    }
}
extension LanguageViewController {
    func configureView() {
        navigationItem.title = "언어 선택"
        
        langTableView.dataSource = self
        langTableView.delegate = self
    }
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codeDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell")!
        cell.textLabel?.text = Array(codeDict.values)[indexPath.row]
        return cell
    }
    
    
}
