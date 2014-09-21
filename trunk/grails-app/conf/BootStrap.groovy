import mgmt.persons.Supplier
import mgmt.procurement.Invoice



class BootStrap {

    def init = { servletContext ->
		for(int i=0;i<100;i++){
			def supplier = new Supplier(cuit:i.hashCode().toString(),name:"Proveedor "+i)
			supplier.save()
			for(int j=0;j<50;j++){
				def invoice = new Invoice(number:j,description:supplier.toString() +': factura '+j,supplier:supplier)
				invoice.save()
			}
			
		}
		
    }
    def destroy = {
    }
}
