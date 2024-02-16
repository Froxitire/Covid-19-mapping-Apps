import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:covid_19/item_card.dart';
import 'package:covid_19/sign_in.dart';
import 'package:covid_19/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covid_19/logic.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String hasilTahunView = "2018";
  List<String> data1 = ["2016", "2017", "2018", "2019", "2020", "2021", "2022"];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    final namacontroller = TextEditingController();
    final rawatcontroller = TextEditingController();
    final konfirmasicontroller = TextEditingController();
    final sembuhcontroller = TextEditingController();
    final meninggalcontroller = TextEditingController();
    final wisatacontroller = TextEditingController();
    final kepadatancontroller = TextEditingController();
    final bulancontroller = TextEditingController();

    final tahuncontroller = TextEditingController();
    CollectionReference users = firebase.collection('users');
    // CollectionReference bulanSeptember = firebase.collection('september');
    // CollectionReference bulanOktober = firebase.collection('oktober');
    // final CollectionReference product =
    //     FirebaseFirestore.instance.collection('users');
    // coba codingan logika ~~~~~
    // void filter() {
    //   final results = firebase
    //       .collection('users')
    //       .where('nama', isEqualTo: "kristin")
    //       .get();

    // }

    // Ujian ujian = Ujian();
    // ujian.setMatPel1(80);
    // ujian.setMatPel2(70);
    // ujian.setMatPel3(40);
    // int jumlah = ujian.jumlahsemua;

    // if (ujian.isLulus()) {
    //   // ignore: avoid_print
    //   print("lulus");
    // } else {
    //   // ignore: avoid_print
    //   print("tidak lulus");
    // }

    // if (umurcontroller.text.isEmpty) {
    //   umurcontroller.text = '0';
    // } else {
    //   umurcontroller.text = umurcontroller.text;
    // }

    // Konversi konversi = Konversi();
    // konversi.setRawat(coba);
    // konversi.setKonfirmasi(43702);
    // konversi.setSembuh(41481);
    // konversi.setMeninggal(2217);
    // konversi.setWisata(4647806);
    // konversi.setKepadatan(5388);

    // if (konversitotal > 0) {
    //   return Konversi().setHasil();
    // }

    // batas uji logika

    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Admin"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              if (FirebaseAuth.instance.currentUser != null) {
                FirebaseAuth.instance.signOut();
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignInPage();
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          children: [
            DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
              ),
              items: data1,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Pilih Tahun",
                  hintText: "Tahun yang dipilih",
                ),
              ),
              onChanged: (value) {
                // ignore: avoid_print
                print(value);
                setState(() {
                  hasilTahunView = value ?? "2018";
                });
              },
              selectedItem: "2018",
            ),
            const SizedBox(height: 40),
            StreamBuilder(
              stream: users
                  .where('tahun', isEqualTo: int.parse(hasilTahunView))
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                if (streamsnapshot.hasData) {
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: streamsnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamsnapshot.data!.docs[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: const Color.fromARGB(179, 0, 0, 0),
                          shadowColor: const Color.fromARGB(137, 37, 104, 143),
                          elevation: 10,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.only(right: 12),
                              decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1, color: Colors.white)),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  users.doc(documentSnapshot['nama']).delete();
                                  showNotification(
                                      context, "data berhasil dihapus");
                                },
                              ),
                            ),
                            title: Text(
                              "Provinsi : ${documentSnapshot['nama']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              documentSnapshot['tahun'].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 250,
                    child: Text("loading...."),
                  );
                }
              },
            ),
            TextField(
              controller: tahuncontroller,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Tahun'),
            ),
            TextField(
              controller: bulancontroller,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Bulan'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: namacontroller,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: rawatcontroller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'jumlah dirawat'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: konfirmasicontroller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(labelText: 'jumlah dikonfirmasi'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: sembuhcontroller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(labelText: 'jumlah pasien sembuh'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: meninggalcontroller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(labelText: 'jumlah pasien meninggal'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: wisatacontroller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: 'jumlah wisatawan per tahun '),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: kepadatancontroller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: 'jumlah kepadatan penduduk per 1km'),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              icon: const Icon(
                Icons.lock_open,
                size: 26,
              ),
              label: const Text(
                "Masukkan data",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                int rawat = int.parse(rawatcontroller.text);
                int konfirmasi = int.parse(konfirmasicontroller.text);
                int sembuh = int.parse(sembuhcontroller.text);
                int meninggal = int.parse(meninggalcontroller.text);
                int wisata = int.parse(wisatacontroller.text);
                int kepadatan = int.parse(kepadatancontroller.text);
                Konversi konversi = Konversi();
                konversi.setRawat(rawat);
                konversi.setKonfirmasi(konfirmasi);
                konversi.setSembuh(sembuh);
                konversi.setMeninggal(meninggal);
                konversi.setWisata(wisata);
                konversi.setKepadatan(kepadatan);
                double perhitungan = konversi.hasil;

                if (namacontroller.text.isNotEmpty &&
                    rawatcontroller.text.isNotEmpty &&
                    konfirmasicontroller.text.isNotEmpty &&
                    sembuhcontroller.text.isNotEmpty &&
                    meninggalcontroller.text.isNotEmpty &&
                    wisatacontroller.text.isNotEmpty &&
                    kepadatancontroller.text.isNotEmpty &&
                    bulancontroller.text.isNotEmpty) {
                  users.doc(namacontroller.text).set({
                    'tahun': int.tryParse(tahuncontroller.text) ?? '0',
                    'bulan': bulancontroller.text,
                    'nama': namacontroller.text,
                    'total rawat': int.tryParse(rawatcontroller.text) ?? '0',
                    'total konfirmasi':
                        int.tryParse(konfirmasicontroller.text) ?? '0',
                    'total sembuh': int.tryParse(sembuhcontroller.text) ?? '0',
                    'total meninggal':
                        int.tryParse(meninggalcontroller.text) ?? '0',
                    'total wisata': int.tryParse(wisatacontroller.text) ?? '0',
                    'total kepadatan':
                        int.tryParse(kepadatancontroller.text) ?? '0',
                    'hasil SAW': perhitungan,
                  });
                } else {
                  showNotification(context, "data tidak valid");
                }

                namacontroller.text = '';
                rawatcontroller.text = '';
                bulancontroller.text = '';

                setState(() {
                  Konversi().hasil = perhitungan;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
