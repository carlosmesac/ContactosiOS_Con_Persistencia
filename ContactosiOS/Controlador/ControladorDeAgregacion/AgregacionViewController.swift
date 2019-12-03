//
//  AgregacionViewController.swift
//  ContactosiOS
//
//  Created by Verónica Rodríguez S. on 29/11/19.
//  Copyright © 2019 Ernestina Martel Jordán. All rights reserved.
//

import UIKit
import CoreData

class AgregacionViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var entradaNombre: UITextField!
    @IBOutlet weak var entradaDireccion: UITextField!
    @IBOutlet weak var entradaTelefono: UITextField!
    @IBOutlet weak var entradaFechaCumple: UIDatePicker!
    var coreDataController:CoreDataController?
    var nuevoContacto: DatosContactoCD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        coreDataController = appDel.coreDataController
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //resignFirstResponder()        // Quito el teclado cuando el usuario da a aceptar        
        return true
    }
    
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("AgregacionViewController prepare: segue=\(String(describing: segue.identifier))")

        if segue.identifier == "retornaDone" {
            if !(entradaNombre.text!.isEmpty) {
                print("Voy a asignar los valores: nombre = \(entradaNombre.text)")

                let imagen = UIImage(named: "persona")
                let foto: NSData = UIImagePNGRepresentation(imagen!)! as NSData
                
                coreDataController?.insertarContacto(nombre: entradaNombre.text!,
                                                     direccion: entradaDireccion.text!,
                                                     telefono: entradaTelefono.text!,
                                                     fechaCumple: entradaFechaCumple.date as NSDate,
                                                     foto: foto)
                print("Contacto añadido")
            }
            else {
                print("los datos estan vacios...")
            }
        }
    }
}
