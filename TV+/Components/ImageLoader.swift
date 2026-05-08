//
//  ImageLoader.swift
//  TV+
//
//  Created by neo on 5/7/26.
//

import SwiftUI
import UIKit
import Combine

struct CachedImageView: View {
    
    let request: LoadImages
    var contentMode: ContentMode = .fill
    @StateObject private var loader = ImageLoader()
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                ProgressView()
            }
        }.task {
            self.loader.load(from: self.request)
        }
    }
        
}

@MainActor
class ImageLoader : ObservableObject {
    @Published var image: UIImage?
    
    func load(from request: LoadImages) {
        if let cachedImage = ImageCache.shared.object(forKey: request.baseUrl + request.url as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: request.baseUrl + request.url ) else {
            print("Invalid URL: \(request.baseUrl + request.url)")
            return
        }
        
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = request.httpMethod
        apiRequest.timeoutInterval = 10
        apiRequest.allHTTPHeaderFields = request.headers

        Task {
            do {
                let (data, response) = try await URLSession.shared.data(for: apiRequest)
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    if let body = String(data: data, encoding: .utf8) {
                        print("Response body: \(body)")
                    }
                    return
                }
                if let img = UIImage(data: data) {
                    ImageCache.shared.setObject(img, forKey: url.absoluteString as NSString)
                    
                    await MainActor.run {
                        self.image = img
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
