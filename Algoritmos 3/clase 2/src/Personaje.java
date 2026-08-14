public class Personaje {
    private int id;
    private String nombre;
    private boolean elegido;

    public Personaje(int id, String nombre, boolean elegido) {
        this.id = id;
        this.nombre = nombre;
        this.elegido = elegido;
    }

    public boolean esElegido(){
        return this.elegido;
    }

    public String getNombre(){
        return this.nombre;
    }

    public void setElegido(boolean elegido) {
        this.elegido = elegido;
    }
}

