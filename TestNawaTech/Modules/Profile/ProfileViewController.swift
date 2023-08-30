//
//  ProfileViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import UIKit

class ProfileViewController: UIViewController{
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var presenter: ProfileViewToPresenterProtocol?
    var settings: [Setting] = [
        .topUp, .statistic, .signOut
    ]
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func setupUI(){
        title = "Profile"
        view.backgroundColor = .systemBackground
        addTableView()
    }
    
    func updateUI(){
        tableView.reloadData()
    }
    
    func addTableView(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
}

extension ProfileViewController: ProfilePresenterToViewProtocol{
    
    func result(result: Result<ProfileSuccessType, Error>) {
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error: error)
        }
    }
    
    func handleSuccess(type: ProfileSuccessType){
        switch type{
        case .successfullyFetchedProfile(let profile):
            self.profile = profile
            updateUI()
        case .successfullyUploadProfilePicture(let url):
            self.profile?.profilePictureUrl = url.absoluteString
            hideBubbleAlert(duration: 0.5)
            updateUI()
        }
    }
    
    func handleError(error: Error){
        presentBubbleAlert(text: String(describing: error), with: 0.2, floating: 1)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as! ProfileHeaderView
        if let profile = profile{
            headerView.setupData(profile: profile)
        }
        headerView.delegate = self
        headerView.accessibilityIdentifier = "profileHeader"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
        cell.setupData(setting: settings[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch settings[indexPath.row]{
        case .signOut:
            presenter?.signOut()
        case .statistic:
            presenter?.goToStatisticVC(from: self)
        case .topUp:
            presenter?.topUp(vc: self)
        }
    }
}

extension ProfileViewController: ProfileHeaderProtocol{
    func userTapProfilePicture() {
        presenter?.presentImagePicker(from: self)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage,
                let id = profile?.id
        else{return}
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else{return}
            self.presenter?.uploadProfilePicture(user: id, image: image)
            self.presentBubbleAlert(text: "Uploading Image", with: 0.5, floating: nil)
        }
    }
}
