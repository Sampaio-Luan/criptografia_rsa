import 'dart:math';

class Desencriptar {
  int e;
  int n;
  int aux = 0;
  List<int> textoCripto;
  List<int> listaCripto;
  List<String> descriptoStr = [];
  List<int> descriptoInt = [];
  List<int> publico = [];
  List<String> letras =
      ' abcdefghijklmnopqrstuvwxyzãçé,:!?êABCDEFGHIJKLMNOPQRSTUVWXYZÃÇÁÉÊÁ'
          .split('');

  Desencriptar(
    this.e,
    this.n,
    this.textoCripto,
    this.listaCripto,
  ) {
    iniciarDesencriptar();
  }

  iniciarDesencriptar() {


    for (int i = 0; publico.length < letras.length; i++) {
      aux = fuckFunction(listaCripto[i], e, n);
      publico.add(aux);
    }


     for (int i = 0; i < textoCripto.length; i++) {
      for (int j = 0; j < publico.length; j++) {
        if (fuckFunction(textoCripto[i], e, n) == publico[j]) {
          descriptoInt.add(publico[j]);
        }
      }
    }

  }

  String retornaDescripto() {
    for (int i = 0; i < descriptoInt.length; i++) {
      for (int j = 0; j < letras.length; j++) {
        if (descriptoInt[i] == publico[j]) {
          descriptoStr.add(letras[j]);
        }
      }
    }
    return descriptoStr.join('');
  }

  fuckFunction(int msg, int key, int n) {
    return pow(msg, key) % n;
  }
}
