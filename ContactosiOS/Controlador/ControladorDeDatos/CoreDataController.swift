//
//  CoreDataController.swift
//  Contactos iOS
//

import UIKit
import CoreData
//Nombre de la base de datos: MisContactosPEM
//Nombre de la tabla: Contactos

class CoreDataController: NSObject {

    var managedObjectContext: NSManagedObjectContext
        
    override init() {
        // Creación de la URL del modelo de datos creado
        
        guard let modelURL =
            Bundle.main.url(forResource: "MisContactosPEM", withExtension: "momd")
            else {
            fatalError("Error en la carga del modelo")
        }
        // Objeto para manejar el modelo desde la aplicación. Es un error fatal no poder recuperar y cargar este modelo
        
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error iniciando el objeto desde: \(modelURL)")
        }
        let psc =
            NSPersistentStoreCoordinator(managedObjectModel: mom)
            
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        self.managedObjectContext.persistentStoreCoordinator = psc
            
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
        let docURL = urls[urls.endIndex-1]
        
        // Lugar de almacenamiento de la base de datos
        let storeURL = docURL.appendingPathComponent("MisContactosPEM")
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            
        } catch {
            fatalError("Error creando el almacenamiento: \(error)")
        }
    }

    
    func insertarContacto(nombre: String, direccion: String, telefono: String, fechaCumple: NSDate, foto: NSData) {
        
        // se obtiene una referencia a la entidad a la que se va a añadir un nuevo dato
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Contactos", into: managedObjectContext) as! DatosContactoCD
        
        // se añaden los datos
        entity.setValue(nombre, forKey:"nombre")
        entity.setValue(direccion, forKey:"direccion")
        entity.setValue(telefono, forKey:"telefono")
        entity.setValue(fechaCumple, forKey:"fechaCumple")
        entity.setValue(foto, forKey:"foto")

        

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Fallo al salvar la entidad: \(error)")
        }

        
    
    }
    
    func cogerContactos() -> [DatosContactoCD] {
        
        // se obtiene una referencia a la tabla para hacer búsquedas
        let contactosFetch =
            NSFetchRequest<NSFetchRequestResult>(entityName: "Contactos")
        
        do {
            // se recupera los registros de la tabla en un array de tipo DatosD eContactoCD
            let listaDeContactos = try managedObjectContext.fetch(contactosFetch) as! [DatosContactoCD]
            return listaDeContactos
        } catch {
            fatalError("Falló al buscar el contacto: \(error)")
        }
    }
    
    
}

    

