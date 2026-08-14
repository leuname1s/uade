public class Cliente {
    private int numeroCliente;
    private String nombre;
    private float deuda;

    public Cliente() {
    }

    public Cliente(int numeroCliente, String nombre, float deuda) {
        this.numeroCliente = numeroCliente;
        this.nombre = nombre;
        this.deuda = deuda;
    }
    void mostrarDatos(){
        System.out.println("numero cliente: "+numeroCliente);
        System.out.println("nombre: "+nombre);
        System.out.println("deuda: "+deuda);
    }

    public int getNumeroCliente() {
        return numeroCliente;
    }

    public void setNumeroCliente(int numeroCliente) {
        this.numeroCliente = numeroCliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public float getDeuda() {
        return deuda;
    }

    public void setDeuda(float deuda) {
        this.deuda = deuda;
    }
}
