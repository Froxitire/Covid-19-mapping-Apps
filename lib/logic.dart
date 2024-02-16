class Ujian {
  late int matPel1;
  late int matPel2;
  late int matPel3;
  late int jumlahsemua = matPel1 + matPel2 + matPel3;

  setMatPel1(int nilai) {
    matPel1 = nilai;
  }

  setMatPel2(int nilai) {
    matPel2 = nilai;
  }

  setMatPel3(int nilai) {
    matPel3 = nilai;
  }

  bool isLulus() {
    int jumlahNilai = matPel1 + matPel2 + matPel3;
    double rata2 = jumlahNilai / 3;
    if (rata2 < 70) {
      return false;
    }
    return true;
  }
}

class Konversi {
  late double a1Rawat = 0;
  late double a1Konfirmasi = 0;
  late double a1Sembuh = 0;
  late double a1Meninggal = 0;
  late double a1Wisata = 0;
  late double a1Kepadatan = 0;
  double bobotRawat = 30;
  double bobotKonfirmasi = 20;
  double bobotSembuh = 15;
  double bobotMeninggal = 15;
  double bobotWisata = 10;
  double bobotKepadatan = 10;

  setRawat(int nilai) {
    if (nilai <= 50) {
      nilai = 25;
    } else if (nilai <= 150) {
      nilai = 50;
    } else if (nilai <= 300) {
      nilai = 75;
    } else if (nilai > 300) {
      nilai = 100;
    }
    late double nilaiRawat = nilai / 100;
    a1Rawat = nilaiRawat;
  }

  setKonfirmasi(int nilai) {
    if (nilai <= 30000) {
      nilai = 20;
    } else if (nilai <= 100000) {
      nilai = 40;
    } else if (nilai <= 200000) {
      nilai = 60;
    } else if (nilai <= 400000) {
      nilai = 80;
    } else if (nilai > 400000) {
      nilai = 100;
    }
    double nilaiKonfirmasi = nilai / 100;
    a1Konfirmasi = nilaiKonfirmasi;
  }

  setSembuh(int nilai) {
    if (nilai <= 30000) {
      nilai = 20;
    } else if (nilai <= 100000) {
      nilai = 40;
    } else if (nilai <= 200000) {
      nilai = 60;
    } else if (nilai <= 400000) {
      nilai = 80;
    } else if (nilai > 400000) {
      nilai = 100;
    }
    double nilaiSembuh = 20 / nilai;
    a1Sembuh = nilaiSembuh;
  }

  setMeninggal(int nilai) {
    if (nilai <= 1000) {
      nilai = 25;
    } else if (nilai <= 5000) {
      nilai = 50;
    } else if (nilai <= 10000) {
      nilai = 75;
    } else if (nilai > 10000) {
      nilai = 100;
    }
    double nilaiMeninggal = nilai / 100;
    a1Meninggal = nilaiMeninggal;
  }

  setWisata(int nilai) {
    if (nilai <= 6000000) {
      nilai = 20;
    } else if (nilai <= 12000000) {
      nilai = 40;
    } else if (nilai <= 25000000) {
      nilai = 60;
    } else if (nilai <= 50000000) {
      nilai = 80;
    } else if (nilai > 50000000) {
      nilai = 100;
    }
    double nilaiRawat = nilai / 100;
    a1Wisata = nilaiRawat;
  }

  setKepadatan(int nilai) {
    if (nilai <= 5000) {
      nilai = 20;
    } else if (nilai <= 10000) {
      nilai = 40;
    } else if (nilai <= 20000) {
      nilai = 60;
    } else if (nilai <= 40000) {
      nilai = 80;
    } else {
      nilai = 100;
    }
    double nilaiKepadatan = nilai / 100;
    a1Kepadatan = nilaiKepadatan;
  }

  // void setHasil() {
  //   double hasil = (a1Rawat * bobotRawat) +
  //       (a1Kepadatan * bobotKonfirmasi) +
  //       (a1Sembuh * bobotSembuh) +
  //       (a1Meninggal * bobotMeninggal) +
  //       (a1Wisata * bobotWisata) +
  //       (a1Kepadatan * bobotKepadatan);
  // }

  late double hasil = (a1Rawat * bobotRawat) +
      (a1Konfirmasi * bobotKonfirmasi) +
      (a1Sembuh * bobotSembuh) +
      (a1Meninggal * bobotMeninggal) +
      (a1Wisata * bobotWisata) +
      (a1Kepadatan * bobotKepadatan);
}
