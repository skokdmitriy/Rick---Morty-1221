//
//  CharactersViewController.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 17.08.2023.
//

import UIKit

final class CharactersViewController: UIViewController {

	private lazy var collectionView = makeCollectionView()
	var viewModel: CharacterViewModelProtocol!

	// MARK: - ViewDidLoad

	override func viewDidLoad() {
		super.viewDidLoad()

		fetchData()
		configureLayout()
		configureNavigationBar()
	}
}

// MARK: - Private Methods

private extension CharactersViewController {
	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 156, height: 203)
		layout.sectionInset = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
		layout.minimumLineSpacing = 16
		layout.minimumInteritemSpacing = 16
		layout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.alwaysBounceVertical = true
		collectionView.backgroundColor = UIColor(hex: Colors.background)
		collectionView.register(
			CharacterCollectionViewCell.self,
			forCellWithReuseIdentifier: Constants.cellIdentifier
		)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}

	func fetchData() {
		Task {
			await viewModel.fetchInitialCharacters()
		}
	}

	func configureLayout() {
		view.addSubview(collectionView)

		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	func configureNavigationBar() {
		title = Constants.title
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.backButtonTitle = ""
	}
}

// MARK: - UICollectionViewDataSource

extension CharactersViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.characters?.count ?? 0
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: Constants.cellIdentifier,
			for: indexPath
		) as? CharacterCollectionViewCell,
			  let character = viewModel.characters?[indexPath.item] else {
			return UICollectionViewCell()
		}
		cell.configureData(character)
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharactersViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return viewModel.isLoading ? CGSize(width: collectionView.frame.width, height: 50) : .zero
	}
}

// MARK: - UICollectionViewDelegate

extension CharactersViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.tapOnTheCharacter(indexPath: indexPath)
	}

	// MARK: Scrolling

	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		let buffer = 4
		if indexPath.row == viewModel.characters?.count ?? 0 - buffer && !viewModel.isLoading {
			Task {
				await viewModel.fetchNextCharacters()
			}
		}
	}
}

// MARK: - CharactersViewProtocol

extension CharactersViewController: CharactersViewProtocol {
	func didLoadNewCharacters(indexPaths: [IndexPath]) {
		collectionView.performBatchUpdates {
			collectionView.insertItems(at: indexPaths)
		}
	}

	func failure(error: NetworkError) {
		let alertMessage: String

		switch error {
		case .badRequest:
			alertMessage = Constants.badRequest
		case .badResponse:
			alertMessage = "Сервер вернул некорректный ответ."
		case .localized(description: let description):
			alertMessage = description
		}

		showError(description: alertMessage)
	}

	private func showError(description: String? = nil) {
		let alert = UIAlertController(
			title: Constants.alertTitle,
			message: description,
			preferredStyle: .alert
		)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
}
