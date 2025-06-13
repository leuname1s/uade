function ejercicio2() {
  const primero = parseInt(prompt("Ingrese el primer número:"));
  const segundo = parseInt(prompt("Ingrese el segundo número:"));
  const tercero = parseInt(prompt("Ingrese el tercer número:"));

  if (tercero < primero && segundo > primero) {
    alert("multiplicando...");
    alert(primero * segundo * tercero);
  } else {
    alert("sumando...");
    alert(primero + segundo + tercero);
  }
}