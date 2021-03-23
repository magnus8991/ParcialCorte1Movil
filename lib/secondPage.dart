import 'package:flutter/material.dart';
import 'package:parcial_primer_corte/globals.dart';
import 'persona.dart';
import 'controlfecha.dart';

void main() => runApp(SecondPage());

// ignore: must_be_immutable
class SecondPage extends StatefulWidget {
  BuildContext principalContext;
  Persona persona;
  String accion;
  SecondPage({this.principalContext, this.accion, this.persona});
  Globals globals = Globals();

  @override
  State<StatefulWidget> createState() {
    return new _SecongPageState();
  }
}

class _SecongPageState extends State<SecondPage> {
  TextEditingController controladorfoto;
  TextEditingController controladornombre;
  TextEditingController controladorapellido;
  TextEditingController controladorprofesion;
  BasicDateField basicDateField;

  @override
  void initState() {
    basicDateField = BasicDateField(widget.persona.fechaNacimiento);
    controladorfoto = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.persona.foto)
        : TextEditingController();
    controladornombre = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.persona.nombre)
        : TextEditingController();
    controladorapellido = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.persona.apellido)
        : TextEditingController();
    controladorprofesion = (widget.accion == 'Actualizar')
        ? TextEditingController(text: widget.persona.profesion)
        : TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.accion + ' persona',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.accion + ' persona'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: widget.globals.crearCampo(controladorfoto, 'URL Foto'),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child:
                      widget.globals.crearCampo(controladornombre, 'Nombres'),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: widget.globals
                      .crearCampo(controladorapellido, 'Apellidos'),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: basicDateField,
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: widget.globals
                      .crearCampo(controladorprofesion, 'Profesión'),
                ),
                // Boton
                ElevatedButton(
                  onPressed: () {
                    validarCampos(context);
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validarCampos(BuildContext context) {
    if (controladorfoto.text.isNotEmpty &&
        controladornombre.text.isNotEmpty &&
        controladorapellido.text.isNotEmpty &&
        controladorprofesion.text.isNotEmpty) {
      mapearPersona();
      widget.globals.mostrarOpciones(
          context,
          () => ejecutarAccion(),
          widget.accion,
          Icons.person,
          '¿Está seguro que desea guardar los cambios de ' +
              widget.persona.nombre +
              '?',
          'Aceptar',
          Icons.check,
          Colors.green);
    } else {
      widget.globals.mostrarAdvertencia(
          context, 'Hay campos vacíos, por favor verifique');
    }
  }

  mapearPersona() {
    widget.persona.foto = controladorfoto.text;
    widget.persona.nombre = controladornombre.text;
    widget.persona.apellido = controladorapellido.text;
    widget.persona.profesion = controladorprofesion.text;
    widget.persona.fechaNacimiento = basicDateField.getFechaActual();
  }

  ejecutarAccion() {
    Navigator.pop(widget.principalContext, widget.persona);
    Navigator.pop(widget.principalContext, widget.persona);
  }
}
