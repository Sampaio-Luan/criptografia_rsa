class Rsa {
  int p;
  int q;
  late int n;
  late int z;
  late int d;
  late int e;

  Rsa(
    this.p,
    this.q,
  ) {
    preencheVariaveis(p, q);
  }

  preencheVariaveis(int p, int q) async {
    n = p * q;
    z = (p - 1) * (q - 1);

    for (int i = 2; i < z; i++) {
      if (saoPrimosEntreSi(i, z) == true) {
        d = i;
        break;
      }
    }
    e = 0;

    while ((e * d) % z != 1) {
      e++;
    }
  }

  int calculaD(int z, int e) {
    int k = 1;
    while (true) {
      k += z;
      if (k % e == 0) {
        return (k ~/ e);
      }
    }
  }

  bool ePrimo(int numero) {
    if (numero < 2) return false;
    for (int i = 2; i * i <= numero; i++) {
      if (numero % i == 0) return false;
    }
    return true;
  }

  int maximoDcomum(int a, int b) {
    while (b != 0) {
      int t = b;
      b = a % b;
      a = t;
    }
    return a;
  }

  bool saoPrimosEntreSi(int a, int b) {
    return maximoDcomum(a, b) == 1;
  }
}
