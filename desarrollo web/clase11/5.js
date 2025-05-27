function ejercicio5() {
  let cantidadPares = 0;
  let cantidadImpares = 0;
  let sumaPares = 0;
  let sumaImpares = 0;

  for (let i = 1; i <= 10; i++) {
    let numero = parseInt(prompt(`Ingrese el número ${i} de 10:`));

    if (numero % 2 == 0) {
      cantidadPares++;
      sumaPares += numero;
    } else {
      cantidadImpares++;
      sumaImpares += numero;
    }
  }

  alert(`Cantidad de pares: ${cantidadPares}\nCantidad de impares: ${cantidadImpares}`);
  alert(`Suma de pares: ${sumaPares}\nSuma de impares: ${sumaImpares}`);

  if (sumaPares > sumaImpares) {
    alert("El grupo de pares tuvo la suma más alta.");
  } else if (sumaImpares > sumaPares) {
    alert("El grupo de impares tuvo la suma más alta.");
  } else {
    alert("Las sumas de pares e impares son iguales.");
  }
}
