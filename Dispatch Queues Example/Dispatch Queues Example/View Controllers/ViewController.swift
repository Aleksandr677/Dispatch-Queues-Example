//
//  ViewController.swift
//  Dispatch Queues Example
//
//  Created by Александр Христиченко on 11.06.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var imageViews: [UIImageView]!
    
    // MARK: -
    
    private lazy var images: [URL] = [
        URL(string: "https://cdn.cocoacasts.com/7ba5c3e7df669703cd7f0f0d4cefa5e5947126a8/1.jpg")!,
        Bundle.main.url(forResource: "2", withExtension: "jpg")!,
        URL(string: "https://cdn.cocoacasts.com/7ba5c3e7df669703cd7f0f0d4cefa5e5947126a8/3.jpg")!,
        Bundle.main.url(forResource: "4", withExtension: "jpg")!
    ]
    
    private let dispatchQueue = DispatchQueue(label: "My Dispatch Queue")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Start \(Date())")
        
        for (index, imageView) in imageViews.enumerated() {
            // Fetch URL
            let url = images[index]
            
            dispatchQueue.async { [weak self] in
                // Populate Image View
                self?.loadImage(with: url, for: imageView)
            }
        }
        
        print("Finish \(Date())")
    }
    
    // MARK: - Helper Methods
    
    private func loadImage(with url: URL, for imageView: UIImageView) {
        // Load Data
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        
        // Create Image
        let image = UIImage(data: data)
        
        DispatchQueue.main.async {
            // Update Image View
            imageView.image = image
        }
    }
}


