//
//  RootViewController.swift
//  YumemiWeatherApp
//
//  Created by Takeya Shimizu on 2022/02/14.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: Lifecycle

    override func loadView() {
        print("[lifecycle (VC)]", #function)
        super.loadView()
    }

    override func viewDidLoad() {
        print("[lifecycle (VC)]", #function)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("[lifecycle (VC)]", #function)
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        print("[lifecycle (VC)]", #function)
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        print("[lifecycle (VC)]", #function)
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("[lifecycle (VC)]", #function)
        super.viewDidAppear(animated)

        //ViewController に遷移
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("[lifecycle (VC)]", #function)
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("[lifecycle (VC)]", #function)
        super.viewDidDisappear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
