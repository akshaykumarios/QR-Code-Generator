//
//  ViewController.swift
//  QR Generator
//
//  Created by Akshay Kumar on 30/01/23.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(qrImageView)
        qrImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qrImageView.frame = CGRect(x: 45, y: view.frame.size.width/2 + 80, width: 300, height: 300)
        qrImageView.image = generateQRCode(from: "https://github.com/akshaykumarios") // replace your url
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else { return nil }
            let transformScale = CGAffineTransform(scaleX: 30.0, y: 30.0)
            let scaledQRImage = QRImage.transformed(by: transformScale)
            return UIImage(ciImage: scaledQRImage)
        }
        return nil
    }
}
