//
//  NetworkManager.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/12.
//

import Foundation
import Alamofire

enum NetworkError: Int, Error, LocalizedError {
    case missingParameter = 400
    case unauthorizaed = 401
    case permissionDenied = 403
    case invalidServer = 500
    
    var errorDescription: String {
        switch self {
        case .missingParameter:
            return "검색어를 입력해주세요."
        case .unauthorizaed:
            return "인증 정보가 없습니다."
        case .permissionDenied:
            return "권한이 없습니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        }
    }
}

class Network {
    static let shared = Network()
    private init() {}
    
    typealias NetworkCompletion<T> = (Result<T, NetworkError>) -> Void
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completion: @escaping NetworkCompletion<T> ) {
        print(#function)
        
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = NetworkError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
}

