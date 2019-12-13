//
//  ContactosEnGridViewController.swift
//  ContactosiOS
//
//  Created by alumno on 13/12/2019.
//  Copyright © 2019 Ernestina Martel Jordán. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "CeldaContactoConFoto"
var coreDataController:CoreDataController?

class ContactosEnGridViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
        
        
         let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataController = appDel.coreDataController

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return coreDataController!.cogerContactos().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // Configure the cell
    
        let listaDeContactos = coreDataController!.cogerContactos()
        let datos = listaDeContactos[indexPath.row]
        if let imagen = datos.value(forKey: "foto"){
            cell.imageView.image = UIImage(data: imagen as! Data)
        }
        
        cell.etiqueta.text = datos.telefono
        return cell
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       print("MasteriviewController prepare: segue=\(String(describing: segue.identifier))")
       
           if segue.identifier == "MuestraDetallesDelContacto" {
            let celda : UICollectionViewCell = sender as! UICollectionViewCell
            if let indexPath = self.collectionView?.indexPath(for: celda) {
                    let controladorVistaDetalle = segue.destination as! DetailViewController
                
                controladorVistaDetalle.datosDeContacto = coreDataController?.cogerContactos()[indexPath.row]
                   controladorVistaDetalle.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                   controladorVistaDetalle.navigationItem.leftItemsSupplementBackButton = true
               }
           }
       }
    
    // MARK: - Segues
    @IBAction func cancel(segue: UIStoryboardSegue) {
        print("MasteriviewController cancel: segue=\(String(describing: segue.identifier))")
        if segue.identifier == "retornaCancel" {
            // cerramos escena de agregación
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print(segue.identifier)
            print("Falló el retorno del segue en CANCEL")
        }
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
        
        print("MasteriviewController done: segue=\(String(describing: segue.identifier))")
        
        if segue.identifier == "retornaDone" {
            // obtener el controlador de agregación
            let controladorAgregacion = segue.source as! AgregacionViewController

            //recarga los datos de la tabla
            self.collectionView!.reloadData()
            //Cierra la escena de agregación
            self.dismiss(animated: true, completion: nil)
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
