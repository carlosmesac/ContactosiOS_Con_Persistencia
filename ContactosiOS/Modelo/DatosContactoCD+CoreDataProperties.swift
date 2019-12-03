//
//  Contactos+CoreDataProperties.swift
//  ContactosiOS
//
//  Created by alumno on 3/12/19.
//  Copyright © 2019 Ernestina Martel Jordán. All rights reserved.
//
//

import Foundation
import CoreData


extension DatosContactoCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DatosContactoCD> {
        return NSFetchRequest<DatosContactoCD>(entityName: "Contactos")
    }

    @NSManaged public var nombre: String
    @NSManaged public var direccion: String
    @NSManaged public var telefono: String
    @NSManaged public var fechaCumple: NSDate
    @NSManaged public var foto: NSData

}
