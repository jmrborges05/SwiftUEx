//
//  UINavigationControllerExtension.swift
//  smiity
//
//  Created by João Borges on 16/06/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation

extension UINavigationController {

     func pushViewController( viewController: UIViewController, animated: Bool, completion: () -> Void ) {
          pushViewController( viewController, animated: animated )
          setCompletionHandler( completion )
     }

     func popViewControllerAnimated( animated: Bool, completion: () -> Void ) {
          popViewControllerAnimated( animated )
          setCompletionHandler( completion )
     }

     func popToViewController( viewController: UIViewController, animated: Bool, completion: () -> Void ) {
          popToViewController( viewController, animated: animated )
          setCompletionHandler( completion )
     }

     func popToRootViewControllerAnimated( animated: Bool, completion: () -> Void ) {
          popToRootViewControllerAnimated( animated )
          setCompletionHandler( completion )
     }

     private func setCompletionHandler( completion: () -> Void ) {
          if let coordinator = transitionCoordinator() {
               coordinator.animateAlongsideTransition( nil ) { _ in
                    completion()
               }
          } else {
               assertionFailure()
          }
     }
}
