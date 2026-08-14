

void main() {
    Cliente cliente1 = new Cliente(1,"jose",100);
    Cliente cliente2 = new Cliente(2,"pepe",2);
    Cliente cliente3 = new Cliente(3,"marcos",0);
    Cliente cliente4 = new Cliente();

    cliente4.setNumeroCliente(4);
    cliente4.setNombre("sofia");
    cliente4.setDeuda(300);

    cliente1.mostrarDatos();
    cliente2.mostrarDatos();
    cliente3.mostrarDatos();

    System.out.println(cliente4.getNombre());
}
