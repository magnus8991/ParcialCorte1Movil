class Persona {
  String foto;
  String nombre;
  String apellido;
  String profesion;
  DateTime fechaNacimiento;
  int edad;

  Persona(
      {this.foto,
      this.nombre,
      this.apellido,
      this.profesion,
      this.fechaNacimiento});

  String calcularEdad() {
    double edad = DateTime.now().difference(this.fechaNacimiento).inDays / 365;
    return edad.toInt().toString();
  }

  String mostrarFechaYEdad() {
    return this.fechaNacimiento.day.toString() +
        '/' +
        this.fechaNacimiento.month.toString() +
        '/' +
        this.fechaNacimiento.year.toString() +
        '\n' +
        this.calcularEdad() +
        ' años';
  }
}
