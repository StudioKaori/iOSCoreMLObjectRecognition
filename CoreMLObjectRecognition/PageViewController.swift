//
//  PageViewController.swift
//  CoreMLObjectRecognition
//
//  Created by Kaori Persson on 2022-05-19.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var controllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageViewController()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupPageViewController() {
        
        let mobileNetVC = storyboard?.instantiateViewController(withIdentifier: "MobileNetVC") as! UIViewController
        
        let yoloVC = storyboard?.instantiateViewController(withIdentifier: "YoloVC") as! UIViewController
        
        controllers = [mobileNetVC,yoloVC]
        setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController),
           index < controllers.count - 1 {
            return controllers[index + 1]
        }
        return nil
    }
    
    
}
