import 'package:flutter/material.dart';
import 'package:parcial_primer_corte/globals.dart';
import 'package:parcial_primer_corte/principal.dart';

void main() => runApp(Login());

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  Globals globals = Globals();
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.login),
        ),
        title: Text('Iniciar sesión'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              CircleAvatar(
                radius: 80,
                child: Image(
                    height: 600,
                    width: 600,
                    image: NetworkImage(
                        'https://cdn.icon-icons.com/icons2/827/PNG/512/user_icon-icons.com_66546.png')),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child:
                    globals.crearCampo(usernameController, 'Nombre de usuario'),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: globals.crearCampoClave(
                    passwordController, 'Contraseña', true),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Principal(usernameController.text)));
                    } else {
                      globals.mostrarAdvertencia(
                          context, 'Hay campos vacíos, por favor verifique');
                    }
                  },
                  child: Text('Ingresar'))
            ],
          ),
        ),
      ),
    );
  }
}
