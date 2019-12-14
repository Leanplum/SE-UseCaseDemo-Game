//
//  OnboardPageViewController.swift
//  Leanplum Game Demo - Tic Tac Toe
//
//  Created by Zach Owens on 11/20/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit

class OnboardPageViewController: UIPageViewController {
    
    var index = 0

    var onboardTrack = LPVar.define("onboard", with: false)
    var LPindex = LPVar.define("LPindex", with: 1 )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let firstVC = orderVC.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            print("Onboard Page View")
        }
        
        Leanplum.onVariablesChanged ({
            self.index = (self.LPindex?.integerValue())!
        })
    
    }
    
    private lazy var orderVC: [UIViewController] = {
        return [self.screenNumVC(screen: "1"),self.screenNumVC(screen: "2"),self.screenNumVC(screen: "3")]
    }()
    
    private func screenNumVC(screen: String) -> UIViewController {
        if #available(iOS 13.0, *) {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "\(screen)Onboarding")
        } else {
            // Fallback on earlier versions
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(screen)Onboarding")
        }
        
    }

}

extension OnboardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = orderVC.firstIndex(of: viewController)
            else {
                return nil
        }
    
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderVC.count > previousIndex else {
            return nil
        }
        
        return orderVC[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                      
        guard let vcIndex = orderVC.firstIndex(of: viewController)
            else {
                return nil
            }
        
        let nextIndex = vcIndex + index
        let orderedVCCount = orderVC.count
            
        guard orderedVCCount != nextIndex else {
                return nil
            }
            
        guard orderedVCCount > nextIndex else {
                return nil
            }
            
        return orderVC[nextIndex]
        
        }
    
}


