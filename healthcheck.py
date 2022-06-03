#!/usr/bin/env python3

import uno
import unohelper

from com.sun.star.beans import PropertyValue


def props(properties):
    '''Create a UNO-compliant tuple of properties, from tuple p_properties
       containing sub-tuples (s_propertyName, value).'''
    res = []
    for name, value in properties:
        prop = PropertyValue()
        prop.Name = name
        prop.Value = value
        res.append(prop)
    return tuple(res)


docPath = "~/healthcheck.odt"
resPath = "~/healthcheck.pdf"
docUrl = unohelper.systemPathToFileUrl(docPath)
# Get the uno component context from the PyUNO runtime
ctx = uno.getComponentContext()
# Create the UnoUrlResolver
create = ctx.ServiceManager.createInstanceWithContext
resolver = create('com.sun.star.bridge.UnoUrlResolver', ctx)
# Connect to LO running on self.port
# docContext = resolver.resolve('uno:socket,host=libreoffice,port=2002;urp;StarOffice.ComponentContext')
docContext = resolver.resolve('uno:socket,host=0.0.0.0,port=2002;urp;StarOffice.ComponentContext')

oo = docContext.ServiceManager.createInstanceWithContext('com.sun.star.frame.Desktop', docContext)

doc = oo.loadComponentFromURL(docUrl, "_blank", 0, props([('Hidden', True)]))

doc.storeToURL(unohelper.systemPathToFileUrl(resPath),
               props([('FilterName', "writer_pdf_Export"), ('UpdateDocMode', 3)]))
