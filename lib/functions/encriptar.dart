import 'dart:math';

class Encriptar {
  int d;
  int n;
  String texto;
  int aux = 0;
  List<String> listTexto = [];
  List<int> textoCripto = [];
  List<int> listaCripto = [];
  List<String> letras =
      ' abcdefghijklmnopqrstuvwxyzãçé,:!?êABCDEFGHIJKLMNOPQRSTUVWXYZÃÇÁÉÊÁ'
          .split('');

  Encriptar(
    this.d,
    this.n,
    this.texto,
  ) {
    iniciarEncriptar();
  }

  iniciarEncriptar() {
    listTexto = texto.split('');


    for (int i = 0; listaCripto.length < letras.length; i++) {
      aux = fuckFunction(i, d, n);
      if (aux != 0) {
        listaCripto.add(aux);
      }
    }

    for (int i = 0; i < listTexto.length; i++) {
      for (int j = 0; j < letras.length; j++) {
        if (listTexto[i] == letras[j]) {
          textoCripto.add(listaCripto[j]);
        }
      }
    }
  }

  fuckFunction(int msg, int key, int n) {
    return pow(msg, key) % n;
  }
}
