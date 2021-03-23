import 'dart:ui';
import 'package:parcial_primer_corte/globals.dart';

import 'persona.dart';
import 'secondPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Principal('',), debugShowCheckedModeBanner: false));

class PrincipalState extends State<Principal> {
  Globals globals = Globals();
  List<Persona> _personas = [
    Persona(
        foto:
            'https://scontent-bog1-1.xx.fbcdn.net/v/t1.0-9/122963090_3512303025501471_1469206526282794636_o.jpg?_nc_cat=103&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeF6vl-9y4BFcrElbeorRwPF2L39QaJceK7Yvf1Bolx4rqiJ8a5WzcDgT7geHVADQRHVmcqeknD2oma96Hx9gUy9&_nc_ohc=yEtddr5L680AX9FR14W&_nc_ht=scontent-bog1-1.xx&oh=35b134f3f22ba8bbbeac77cefb73fcee&oe=607E6E3A',
        nombre: 'Diego',
        apellido: 'Mandon',
        profesion: 'Ingeniero de sistemas',
        fechaNacimiento: DateTime(1998, 9, 15))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Text('Lista Personas'),
          ]),
          leading: CircleAvatar(
            child: Icon(Icons.list),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          actions: [
            Center(child: Text(widget.username)),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ))
          ],
          centerTitle: false,
          backgroundColor: Colors.lightBlue,
        ),
        body: ListView.builder(
            itemCount: _personas.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    actualizarPersona(context, _personas[index], index);
                  },
                  onLongPress: () {
                    eliminarPersona(context, _personas[index]);
                  },
                  title: Text(_personas[index].nombre +
                      ' ' +
                      _personas[index].apellido),
                  subtitle: Text(_personas[index].profesion),
                  leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(_personas[index].foto)))),
                  trailing: Text(
                    _personas[index].mostrarFechaYEdad(),
                    textAlign: TextAlign.right,
                  ));
            }),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              onPressed: () {
                adicionarPersona(context, _personas);
              },
              tooltip: 'Registrar Persona',
              child: Icon(Icons.add),
            ),
          ),
        ]));
  }

  eliminarPersona(context, Persona persona) {
    globals.mostrarOpciones(
        context,
        () => setState(() {
              this._personas.remove(persona);
              Navigator.pop(context);
            }),
        ' Eliminar Persona',
        Icons.person,
        '¿Está seguro que desea eliminar a ' + persona.nombre + '?',
        'Eliminar',
        Icons.delete,
        Colors.red);
  }

  adicionarPersona(context, List<Persona> personas) async {
    final persona = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (secondContext) => new SecondPage(
              principalContext: context,
              accion: 'Adicionar',
              persona: Persona(fechaNacimiento: DateTime.now()))),
    ) as Persona;
    setState(() {
      if (persona != null) personas.add(persona);
    });
  }

  actualizarPersona(context, Persona personaAntigua, int index) async {
    final personaNueva = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (secondContext) => new SecondPage(
              principalContext: context,
              accion: 'Actualizar',
              persona: personaAntigua)),
    ) as Persona;
    setState(() {
      if (personaNueva != null) {
        this._personas.elementAt(index).foto = personaNueva.foto;
        this._personas.elementAt(index).nombre = personaNueva.nombre;
        this._personas.elementAt(index).apellido = personaNueva.apellido;
        this._personas.elementAt(index).profesion = personaNueva.profesion;
        this._personas.elementAt(index).fechaNacimiento =
            personaNueva.fechaNacimiento;
        this._personas.elementAt(index).edad = personaNueva.edad;
      }
    });
  }
}

// ignore: must_be_immutable
class Principal extends StatefulWidget {
  String username;

  Principal(this.username);

  PrincipalState createState() {
    return PrincipalState();
  }
}
