//
//  PageViewController.swift
//  SwiftUIPageViewController
//
//  Created by Marcelo Sampaio on 2/23/17.
//  Copyright © 2017 Marcelo Sampaio. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // Variables
    lazy var arrayViewControllers: [UIViewController] = {
        return [self.viewControllerInstance(name: "FirstVC"),self.viewControllerInstance(name: "SecondVC"),self.viewControllerInstance(name: "ThirdVC")]
        
    }()
    
    // MARK: - View Controller Instance
    private func viewControllerInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = arrayViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            }else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }

    
    // MARK: - PageViewController DataSource and Delegate
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = arrayViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return arrayViewControllers.last
//            return nil // no carrousel
        }
        
        guard arrayViewControllers.count > previousIndex else {
            return nil
        }
        
        
        return arrayViewControllers[previousIndex]
        
    }
    

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = arrayViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < arrayViewControllers.count else {
            return arrayViewControllers.first
//            return nil // no carrousel
        }
        
        guard arrayViewControllers.count > nextIndex else {
            return nil
        }
        
        
        return arrayViewControllers[nextIndex]
        
        
        
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayViewControllers.count
    }
    
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        // check the current index of view controlle being presented
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = arrayViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
        
        
    }
    
    // MARK: - Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
