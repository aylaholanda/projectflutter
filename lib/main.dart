/*
  App para calcular o IMC de uma pessoa.
  Referências:
  - [Programador BR] https://www.youtube.com/watch?v=hOsSDTxzrKQ
*/

import 'package:flutter/material.dart';
import 'dart:math'; // pow()

class Gasto {
  // Atributos
  String _name;
  double _price;

  Gasto(this._name, this._price) {

  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Gasto> lista = []; // Lista vazia

  // Construtor
  MyApp() {
    Gasto Gasto1 = Gasto("CyberPunk ",200.00);
    Gasto Gasto2 = Gasto("Celular novo ", 2000.00);
    lista.add(Gasto1);
    lista.add(Gasto2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Project ",
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Gasto> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Gasto> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Gastos (${lista.length})"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._name +" "+ lista[index]._price.toString()}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 17.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Opcional
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.blueGrey),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_rounded),
            title: Text(
              "Gastos Totais",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesDoPaciente(lista),
                ),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.money_off),
            title: Text(
              "Gastos",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarPaciente(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(5.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.wallet_travel_sharp),
              title: Text(
                "About",
                style: TextStyle(fontSize: _fontSize),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela Informações do Paciente
//-----------------------------------------------------------------------------
class About extends StatefulWidget  {
  AboutContext createState() => AboutContext();
}
class AboutContext extends State<About> {
  @override
  Widget build(BuildContext context) {
    var titulo = "Gastos Totais";

    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Column(
        children: <Widget>[
          Text("Essa aplicação foi criada para gerenciamento de despesas de forma simples e pratica."),

        ],
      ),
    );
  }
}


class TelaInformacoesDoPaciente extends StatefulWidget {
  final List<Gasto> lista;

  // Construtor
  TelaInformacoesDoPaciente(this.lista);

  @override
  _TelaInformacoesDoPaciente createState() => _TelaInformacoesDoPaciente(lista);
}

class _TelaInformacoesDoPaciente extends State<TelaInformacoesDoPaciente> {
  // Atributos
  final List lista;
  Gasto paciente;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final imcController = TextEditingController();
  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesDoPaciente(this.lista) {
    if (lista.length > 0) {
      index = 0;
      paciente = lista[0];
      nomeController.text = paciente._name;
      pesoController.text = paciente._price.toString();

    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      paciente = lista[index];
      nomeController.text = paciente._name;
      pesoController.text = paciente._price.toString();

      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._name = nomeController.text;
      lista[index]._price = double.parse(pesoController.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Gastos Totais";
    if (paciente == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum Gasto encontrado!"),
            Container(
              color: Colors.blueGrey,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Primeiro',
                child: Text("Editar"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Gasto",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Preço",
                  // hintText: 'Peso do paciente (kg)',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: pesoController,
              ),
            ),

            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TelaCadastrarPaciente extends StatefulWidget {
  final List<Gasto> lista;

  // Construtor
  TelaCadastrarPaciente(this.lista);

  @override
  _TelaCadastrarPacienteState createState() =>
      _TelaCadastrarPacienteState(lista);
}

class _TelaCadastrarPacienteState extends State<TelaCadastrarPaciente> {
  // Atributos
  final List<Gasto> lista;
  String _name = "";
  double _price = 0.0;

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();


  // Construtor
  _TelaCadastrarPacienteState(this.lista);

  // Métodos
  void _cadastrarGasto() {
    _name = _nameController.text;
    _price = double.parse(_priceController.text);

    if (_price > 0 ) {
      var paciente = Gasto(_name, _price); // Cria um novo objeto
      // _imc = paciente._imc;
      lista.add(paciente);
      // _index = lista.length - 1;
      _nameController.text = "";
      _priceController.text = "";

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Gasto "),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Informações de Gastos:",
                style: TextStyle(fontSize: 10),
              ),
            ),
            // --- Nome do Paciente ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome Gasto",
                 
                ),
                style: TextStyle(fontSize: 10),
                controller: _nameController,
              ),
            ),
            // --- Peso do Paciente ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Preço ",

                ),
                style: TextStyle(fontSize: 10),
                controller: _priceController,
              ),
            ),


            RaisedButton(
              child: Text(
                "Cadastrar Gasto",
                style: TextStyle(fontSize: 10),
              ),
              onPressed: _cadastrarGasto,
            ),
          ],
        ),
      ),
    );
  }

}
