import UIKit

extension UIImageView {
	private static let imageLoader = ImageLoaderService()

	@MainActor
	func setImage(by url: URL) async throws {
		let image = try await Self.imageLoader.loadImage(for: url)

		if !Task.isCancelled {
			self.image = image
		}
	}
}
