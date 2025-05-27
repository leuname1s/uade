function ejercicio6() {
  const lista = document.getElementById("lista");

  // Limpiar lista antes de iniciar
  lista.innerHTML = "";

  let answer = parseInt(prompt("Ingrese un número"));
    const nuevoItem = document.createElement("li");
    nuevoItem.textContent = answer;
    lista.appendChild(nuevoItem);

  while (answer <= 10) {
    answer = parseInt(prompt("Ingrese un número"));
    const nuevoItem = document.createElement("li");
    nuevoItem.textContent = answer;
    lista.appendChild(nuevoItem);

  }
}