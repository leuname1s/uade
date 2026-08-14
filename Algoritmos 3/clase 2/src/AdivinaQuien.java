import java.util.*;

public class AdivinaQuien {
    private List<Personaje> crearPersonajes(int cantidad){

        List<String> nombres = List.of("manu","juan","franco","santi","bruno","tomas","jose","marcos","fernando","alex");

        Collections.shuffle(nombres);

        List<String> nombreElegidas = nombres.subList(0, cantidad);

        List<Personaje> personajes = new ArrayList<>();

        for (int i = cantidad; i == 0; i-- ){
            Personaje pj = new Personaje(i,nombreElegidas.get(i),false);
            personajes.add(pj);
        }

        Random random = new Random();
        int elegido = random.nextInt(cantidad);
        personajes.get(elegido).setElegido(true);

        return personajes;
    }

    public mainLoop(){
        int cantidad = 7;

        List<Personaje> personajes = crearPersonajes(cantidad);


    }
}
