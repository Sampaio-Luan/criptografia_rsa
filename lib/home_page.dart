import 'package:criptografia_rsa/functions/desencriptar.dart';
import 'package:criptografia_rsa/functions/encriptar.dart';
import 'package:criptografia_rsa/functions/rsa.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var formKeyE = GlobalKey<FormState>();
  TextEditingController p = TextEditingController();
  TextEditingController q = TextEditingController();
  TextEditingController texto = TextEditingController();
  TextEditingController textoCPri = TextEditingController();
  TextEditingController textoCPub = TextEditingController();
  Rsa rsa = Rsa(17, 11);
  Color cor = Colors.indigo;
  bool ok = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Form(
                      key: formKeyE,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(children: [
                          Expanded(child: campoFormNumero(p, 'p')),
                          const SizedBox(width: 10),
                          Expanded(child: campoFormNumero(q, 'q')),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 7,
                          backgroundColor: Colors.indigo[500],
                          foregroundColor: Colors.white,
                          minimumSize: const Size(200, 50),
                          shadowColor: Colors.white,
                        ),
                        child: const Text("Gerar Chave"),
                        onPressed: () {
                          if (formKeyE.currentState!.validate()) {
                            debugPrint(p.text);
                            debugPrint(q.text);
                            rsa = Rsa(int.parse(p.text), int.parse(q.text));
                            texto.clear();
                            textoCPri.clear();
                            textoCPub.clear();
                           
                            setState(() {
                              ok = true;
                            });
                          } else {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Ambos precisam ser preenchidos com numeros Primos'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            });
                          }
                        }),
                    const SizedBox(height: 15),
                    Text(ok
                        ? 'Sua chave, e: ${rsa.e} n: ${rsa.n}'
                        : ''),
                  ]),
            ),
          ),
          const Divider(),
          ok
              ? Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          campoFormTexto(
                              texto,
                              'Digite aqui Texto a Ser Criptografado',
                              3,
                              false),
                          const SizedBox(height: 30),
                          campoFormTexto(
                              textoCPri, 'Criptografado Privado', 3, true),
                          const SizedBox(height: 30),
                          campoFormTexto(
                              textoCPub, 'Criptografado Publico', 3, true)
                        ],
                      ),
                    ),
                  ),
                )
              : const Text('')
        ],
      ),
    );
  }

  TextFormField campoFormNumero(TextEditingController controle, String lbl) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controle,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cor),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: lbl,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
      onChanged: (value) {
        formKeyE.currentState!.validate();
        setState(() {
          ok = false;
        

        });
      },
      validator: (value) {
        if (value == null) {
          return 'Obrigatório';
        } else if (value.isEmpty) {
          return 'Obrigatório';
        } else if (rsa.ePrimo(int.parse(controle.text)) == false) {
          return 'Não é primo';
        }
        return null;
      },
    );
  }

  TextFormField campoFormTexto(
      TextEditingController controle, String lbl, int linha, bool leitura) {
    return TextFormField(
      keyboardType: TextInputType.text,
      readOnly: leitura,
      minLines: linha,
      maxLines: 50,
      controller: controle,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cor),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        labelText: lbl,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
      onChanged: (value) {
        Encriptar ecpt = Encriptar(rsa.d, rsa.n, texto.text);
        Desencriptar dcpt =
            Desencriptar(rsa.d, rsa.n, ecpt.textoCripto, ecpt.listaCripto);
        textoCPri.text = ecpt.textoCripto.join('');
        textoCPub.text = dcpt.descriptoInt.join('');
        debugPrint(textoCPri.text);
      },
    );
  }
}
