import java.util.Scanner;
import java.util.concurrent.TimeUnit; // Debes importar esta clase

public class ejer1 {
    public void resolver(String palabra){
        Scanner scanner = new Scanner(System.in);
        // char[] palabra = {"b","a","r","i","l","o","c","h","e"};
        // String palabra = "bariloche" 
        System.out.printnl("ingrese una letra:");
        char input = scanner.nextLine();
        // for (char i : palabra){
        //     if i == input{
        //         System.out.printnl("letra encontrada:");
        //         System.out.printnl(i);
        //         break;
        //     }
        // }

        if (palabra.contains(input){
            System.out.println("letra encontrada");
            // System.out.println(i);
        }

        System.out.println("letras totales:");
        System.out.println(palabra.lenght());
        System.out.println();
        // TimeUnit.SECONDS.sleep(1);
        System.out.println("3...");
        // TimeUnit.SECONDS.sleep(1);
        System.out.println("2...");
        // TimeUnit.SECONDS.sleep(1);
        System.out.println("1...");
        // TimeUnit.SECONDS.sleep(1);
    }

    public void main(String args[]){
        resolver("bariloche");
    }
}