//
//  MasterViewController.swift
//  ContactosiOS
//
//  Created by Ernestina Martel Jordán on 5/10/18.
//  Copyright © 2018 Ernestina Martel Jordán. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
        
    var coreDataController:CoreDataController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataController = appDel.coreDataController
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            // obtener nuevo contacto
            if let aux = controladorAgregacion.nuevoContacto {
                // agrega nuevo contacto a la lista
                coreDataController?.insertarContacto(nombre: aux.nombre, direccion: aux.direccion, telefono: aux.telefono, fechaCumple: aux.fechaCumple, foto: aux.foto)           }
            else {
                print("Falló el retorno del segue en done")
                print(controladorAgregacion.nuevoContacto)
            }
            //recarga los datos de la tabla
            self.tableView.reloadData()
            //Cierra la escena de agregación
            self.dismiss(animated: true, completion: nil)
        }
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    print("MasteriviewController prepare: segue=\(String(describing: segue.identifier))")
    
        if segue.identifier == "MuestraDetallesDelContacto" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controladorVistaDetalle  = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controladorVistaDetalle.datosDeContacto = coreDataController?.cogerContactos()[indexPath.row]
                controladorVistaDetalle.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controladorVistaDetalle.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataController!.cogerContactos().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaDatosDeContacto", for: indexPath)

        let etiquetaNombre = cell.textLabel!
        let etiquetaNumero =  cell.detailTextLabel!
        
        if(coreDataController != nil)
        {
            let listaDeContactos = coreDataController!.cogerContactos()
            etiquetaNombre.text = listaDeContactos  [indexPath.row].nombre
             etiquetaNumero.text = listaDeContactos[indexPath.row].telefono
        }else{
            etiquetaNombre.text = ""
            etiquetaNumero.text = ""
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    

}

