//
//  BookViewController.swift
//  NetworkSesac
//
//  Created by 김재석 on 1/17/24.
//

import UIKit
import Alamofire

// MARK: - Book
struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}



class BookViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var bookCollectionView: UICollectionView!
    
    var bookData: Book? {
        didSet{
            bookCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        configureView()
    }
    
    func callRequest(text: String) {
        // 한글 검색이 안되면 인코딩 처리 해야된다.
        let query = text.addingPercentEncoding(withAllowedCharacters:  .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        
        let headers: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]
        
      
        
        
        // form에 넣는 데이터 parameter자리에 dict으로 담아준다.
        // self쓰는 이유: 메서드 내 똑같은 이름의 변수가 있을 수 있으니
        // 클래스에서 쓰는 것이라고 표현하는 것이라고 생각하면 된다.
        AF.request(
            url,
            method: .get,
            headers: headers
        ).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                self.bookData = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(text: searchBar.text!)
    }
    
    func configureView() {
        
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        
        let xib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        bookCollectionView.register(xib, forCellWithReuseIdentifier: "BookCollectionViewCell")
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData!.documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.setDataInCell(data: bookData!.documents[indexPath.row])
        return cell
    }
}

