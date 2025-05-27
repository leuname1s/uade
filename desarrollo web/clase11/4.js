function ejercicio4() {
  const numero = parseInt(prompt("Ingrese el número del día (1 a 7):"));

  switch (numero) {
    case 1:
      alert("lunes");
      break;
    case 2:
      alert("martes");
      break;
    case 3:
      alert("miércoles");
      break;
    case 4:
      alert("jueves");
      break;
    case 5:
      alert("viernes");
      break;
    case 6:
      alert("sábado");
      break;
    case 7:
      alert("domingo");
      break;
    default:
      alert("Número no válido. Debe ser entre 1 y 7.");
  }
}