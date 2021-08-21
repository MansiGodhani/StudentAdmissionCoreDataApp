//
//  RDstudVC.swift
//  StudentAdmissionCoreDataApp
//
//  Created by DCS on 21/08/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class RDstudVC: UIViewController {
    
    var arrayitem = [UIBarButtonItem]()
    private var studArray = Array<Student>()
    private let mytableview = UITableView()
    
    
    private let mybutton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Student Detail"
        view.addSubview(mytableview)
        view.addSubview(mybutton)
        
        let additem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addbuttontapped))
        arrayitem.append(additem)
        navigationItem.setLeftBarButtonItems(arrayitem, animated: true)
        
        setuptableview()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mytableview.frame=view.bounds
        mybutton.frame = CGRect(x: 40, y: 550, width: 100, height: 60)
        
    }
    
    @objc private func addbuttontapped()
    {
        let vc = CUstudVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func fetchData()
    {
        studArray = CoreDataHandler.shared.fetchData()
        
        mytableview.reloadData()
    }
    
    @objc private func logoutTapped()
    {
        UserDefaults.standard.removeObject(forKey: "username")
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
extension RDstudVC : UITableViewDataSource,UITableViewDelegate{
    private func setuptableview(){
        mytableview.dataSource = self
        mytableview.delegate = self
        mytableview.register(UITableViewCell.self, forCellReuseIdentifier: "studcell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studcell", for : indexPath)
        
        let stud = studArray[indexPath.row]
        
        cell.textLabel!.text = "\(stud.name!) | \t \(stud.age) | \t \(stud.classes!)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(studArray[indexPath.row])
        
        let vc = CUstudVC()
        vc.stud = studArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let stud = studArray[indexPath.row]
        
        CoreDataHandler.shared.deleteData(for: stud) { [weak self]  in
            
            print("Data deleted")
            
            //self.fetchData()
            
            self?.studArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
    }
}

