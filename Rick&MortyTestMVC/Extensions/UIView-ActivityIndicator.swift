//
//  UIView.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 18.08.2023.
//

import UIKit

func showSpinner(in view: UIView) -> UIActivityIndicatorView {
  let activityIndicator = UIActivityIndicatorView(frame: view.bounds)
  activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  activityIndicator.startAnimating()
  activityIndicator.color = .white
  activityIndicator.hidesWhenStopped = true
  view.addSubview(activityIndicator)
  return activityIndicator
}
