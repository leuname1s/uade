function ejercicio3() {
  const valorHora = parseInt(prompt("Ingrese su valor por hora:"));
  const horasTrabajadas = parseInt(prompt("Ingrese cuántas horas trabajó:"));
  const antiguedad = parseInt(prompt("Ingrese su antigüedad en años:"));

  const sueldoBruto = 20 * valorHora * horasTrabajadas;
  const sueldoNeto = sueldoBruto - (sueldoBruto * 0.2);

  alert("Su sueldo bruto es de: " + sueldoBruto);
  alert("Su sueldo neto es de: " + sueldoNeto);

  let sueldoFinal = sueldoNeto;

  if (antiguedad > 10) {
    sueldoFinal += 1500;
  } else if (antiguedad > 5) {
    sueldoFinal += 1000;
  }

  alert("Su sueldo final es de: " + sueldoFinal);
}