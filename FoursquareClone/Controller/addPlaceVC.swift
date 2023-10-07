//
//  addPlaceVC.swift
//  FoursquareClone
//
//  Created by umut yalçın on 6.10.2023.
//

import UIKit

class addPlaceVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var placeNametf: UITextField!
    
    @IBOutlet weak var placeTypetf: UITextField!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeAtmospheretf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title : "Back", style: .done, target: self, action: #selector(handleBack))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleNext))
        
        
        placeImageView.isUserInteractionEnabled = true
        let ges = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        placeImageView.addGestureRecognizer(ges)
        
    }
    
    @objc
    func tappedImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    @objc
    func handleNext(){
        if placeNametf.text != "" && placeTypetf.text != "" && placeAtmospheretf.text != "" {
            if let chosenImage = placeImageView.image {
                let placeModel = PlaceModel.shared
                placeModel.placeName = placeNametf.text!
                placeModel.placeType = placeTypetf.text!
                placeModel.placeAtmosphere = placeAtmospheretf.text!
                placeModel.placeImage = chosenImage
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            alert(message: "Boş alan")
        }
    }
    
    @objc
    func handleBack(){
        self.dismiss(animated: true)
    }

}
