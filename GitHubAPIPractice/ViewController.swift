//
//  ViewController.swift
//  GitHubAPIPractice
//
//  Created by Hong James on 2019/7/26.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {

    let searchTextField = UITextField()
    let searchButton = UIButton(type: UIButton.ButtonType.system)
    var resultCollectionView: UICollectionView!
    var resultArray = [User]()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }

    private func initUI() {
        
        self.view.addSubview(self.searchTextField)
        self.view.addSubview(self.searchButton)
        
        self.searchTextField.delegate = self
        self.searchTextField.borderStyle = .roundedRect
        self.searchTextField.placeholder = "欲搜尋內容"
        self.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin).offset(20)
            make.height.equalTo(30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.searchButton.snp.left).offset(-20)
        }
        
        self.searchButton.isEnabled = false
        self.searchButton.setTitle("搜尋", for: .normal)
        self.searchButton.setTitleColor(.white, for: .normal)
        self.searchButton.backgroundColor = .lightGray
        self.searchButton.addTarget(self, action: #selector(searchClick), for: UIControl.Event.touchUpInside)
        
        self.searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.right.equalTo(self.view).offset(-20)
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0.0
        
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.scrollDirection = .vertical
        
        self.resultCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        self.resultCollectionView.delegate = self
        self.resultCollectionView.dataSource = self
        self.resultCollectionView.backgroundColor = .white
        
        self.view.addSubview(self.resultCollectionView)
        self.resultCollectionView!.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(20)
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        self.resultCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ResultCollectionViewCell.self))
    }

    @objc private func searchClick() {
        self.viewModel.search(keyWord: self.searchTextField.text!) { (responeModel, error) in
            self.resultArray.removeAll()
            if let items = responeModel?.items {
                for user in items {
                    self.resultArray.append(user)
                }
            }
            self.resultCollectionView.reloadData()
        }
    }

}

extension ViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (searchTextField.text?.isEmpty)! {
            self.searchButton.backgroundColor = .lightGray
            self.searchButton.isEnabled = false
        } else {
            self.searchButton.backgroundColor = searchButton.tintColor
            self.searchButton.isEnabled = true
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ResultCollectionViewCell.self), for: indexPath) as! ResultCollectionViewCell
        cell.resultImageView.kf.setImage(with: URL(string: self.resultArray[indexPath.row].avatar_url))
        cell.titleLabel.text = self.resultArray[indexPath.row].login
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2 + 30)
    }
}
