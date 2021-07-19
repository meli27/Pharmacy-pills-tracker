//
//  RegularUserPageViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 24/6/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol PageControllerDelegate: AnyObject {
    func pageDidSwipe(toIndex: Int)
}

class RegularUserPageViewController: UIPageViewController {
    private var pages: [UIViewController]!
    private let blogViewController = BlogViewController()
    private let medicineViewController = MedicineViewController()
    private let chatViewController = ChatViewController()
    private let productsViewController = ProductsViewController()
    
    private var previousPage = 0
    
    weak var swipeDelegate: PageControllerDelegate?
    private let disposeBag = DisposeBag()
    let viewModel: RegularUserNavigationViewModel = RegularUserNavigationViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageController()
    }
    
    private func setupPageController() {
        self.dataSource = self
        self.delegate = self
        medicineViewController.view.tag = 0
        blogViewController.view.tag = 1
        chatViewController.view.tag = 2
        productsViewController.view.tag = 3
        pages = [medicineViewController, blogViewController, chatViewController, productsViewController]
        //self.setViewControllers([pages[1]], direction: .forward, animated: true, completion: nil)
        self.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
}

extension RegularUserPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController), viewControllerIndex > 0 else {
            return nil
        }
        return self.pages[viewControllerIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController), viewControllerIndex < self.pages.count - 1 else {
            return nil
        }
        return self.pages[viewControllerIndex + 1]
    }
}

extension RegularUserPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentPageIndex = self.viewControllers?.first?.view.tag else { return }
            previousPage = currentPageIndex
            viewModel.setCurrentController.accept(currentPageIndex)
            self.swipeDelegate?.pageDidSwipe(toIndex: currentPageIndex)
        }
    }
}

extension RegularUserPageViewController: RegularTabBarDelegate {
    func itemSelected(itemIndex: Int) {
        guard itemIndex > previousPage else {
            previousPage = itemIndex
            return self.setViewControllers([pages[itemIndex]], direction: .reverse, animated: true, completion: nil)
        }
        previousPage = itemIndex
        return self.setViewControllers([pages[itemIndex]], direction: .forward, animated: true, completion: nil)
    }
}
