//
//  NetworkService.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import Foundation

enum NetworkError: Error {
	case badRequest
	case badResponse
	case localized(description: String)
}

protocol NetworkServiceProtocol {
	func fetchRequest<T: Decodable>(
		modelType: T.Type,
		with url: URL) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
	private let session = URLSession.shared
	private let decoder = JSONDecoder()

	init() {
		decoder.keyDecodingStrategy = .convertFromSnakeCase
	}

	func fetchRequest<T: Decodable>(
		modelType: T.Type,
		with url: URL) async throws -> T {

			let urlRequest = URLRequest(url: url)
			let (data, response) = try await session.data(for: urlRequest)

			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				throw NetworkError.badResponse
			}
			return try decoder.decode(T.self, from: data)
		}
}
