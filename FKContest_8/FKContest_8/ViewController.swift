//
//  ViewController.swift
//  FKContest_8
//
//  Created by Arthur Narimanov on 3/23/23.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 1000)
        scrollView.delegate = self
        title = "Avatar"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navigationBar = self.navigationController?.navigationBar,
              let UINavigationBarLargeTitleView = NSClassFromString("_UINavigationBarLargeTitleView")
        else { return }
        
        navigationBar.subviews.forEach { subview in
            if subview.isKind(of: UINavigationBarLargeTitleView.self),
               let label = subview.subviews.first(where: { label in
                   return label.isKind(of: UILabel.self)
               }) {
                subview.addSubview(avatarView)
                NSLayoutConstraint.activate([
                    avatarView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                    avatarView.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: -view.directionalLayoutMargins.trailing),
                    avatarView.widthAnchor.constraint(equalToConstant: 36),
                    avatarView.heightAnchor.constraint(equalToConstant: 36),
                ])
            }
        }
    }
}
