//
//  UIImageView+MoviePoster.swift
//  ReduxMovieDB
//
//  Created by Matheus Cardoso on 2/12/18.
//  Copyright © 2018 Matheus Cardoso. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    fileprivate var activityIndicator: UIActivityIndicatorView {
        if let activityIndicator = subviews.compactMap({ $0 as? UIActivityIndicatorView }).first {
            return activityIndicator
        }

        let activityIndicator = UIActivityIndicatorView(style: .white)
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addConstraint(
            NSLayoutConstraint(
                item: activityIndicator,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerX,
                multiplier: 1.0,
                constant: 0.0
            )
        )

        addConstraint(
            NSLayoutConstraint(
                item: activityIndicator,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerY,
                multiplier: 1.0,
                constant: 0.0
            )
        )

        return activityIndicator
    }

    fileprivate func startLoading() {
        activityIndicator.startAnimating()
    }

    fileprivate func stopLoading() {
        activityIndicator.stopAnimating()
    }

    fileprivate var imageBaseUrl: String {
        return "https://image.tmdb.org/t/p/w500"
    }

    func setPosterForMovie(_ movie: Movie) {
        let placeholder = UIImage(named: "poster_placeholder")

        guard let posterPath = movie.posterPath else {
            image = placeholder
            return
        }

        startLoading()

        sd_setImage(
            with: URL(string: "\(imageBaseUrl)\(posterPath)"),
            placeholderImage: placeholder,
            options: [.progressiveDownload, .scaleDownLargeImages]
        ) { [weak self] _, _, _, _ in
            self?.stopLoading()
        }
    }
}
