import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/cardhomeuser.dart';
import 'package:covid_19/sign_in.dart';
// import 'package:covid_19/sign_up.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomepageUser extends StatefulWidget {
  const HomepageUser({Key? key}) : super(key: key);

  @override
  State<HomepageUser> createState() => _HomepageUserState();
}

class _HomepageUserState extends State<HomepageUser> {
  String hasilTahunView = "2022";
  List<String> data1 = ["2016", "2017", "2018", "2019", "2020", "2021", "2022"];

  String hasilBulanView = "juli";
  List<String> data2 = ["juli", "agustus", "september", "oktober", "november"];

  int currentIndex = 0;

  String utamaNama = "";
  String utamaRawat = "";
  String utamaKonfirmasi = "";
  String utamaSembuh = "";
  String utamaMeninggal = "";
  String utamaWisata = "";
  String utamaKepadatan = "";

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    CollectionReference users = firebase.collection('users');

    void ambildata() {
      // FirebaseFirestore.instance.collection('users')
      //   .get().then((value) => {
      //         // ignore: avoid_function_literals_in_foreach_calls
      //         value.docs.forEach((result) {
      //           // ignore: avoid_print
      //           print(result.data());
      //         })
      //       });
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc('jawa barat')
      //     .get()
      //     .then((value) => {
      //           value.data()?.forEach((key, value) {
      //             // ignore: avoid_print
      //             print(key);
      //             // ignore: avoid_print
      //             print(value);
      //           })
      //         });

      FirebaseFirestore.instance
          .collection('users')
          .where('tahun', isEqualTo: 2022)
          .orderBy('hasil SAW', descending: true)
          .limit(1)
          .get()
          .then((value) => {
                // ignore: avoid_function_literals_in_foreach_calls
                value.docs.forEach((element) {
                  element.data()['nama'];
                  String nama = element.data()['nama'];
                  String rawat = element.data()['total rawat'].toString();
                  String konfirmasi =
                      element.data()['total konfirmasi'].toString();
                  String sembuh = element.data()['total sembuh'].toString();
                  String meninggal =
                      element.data()['total meninggal'].toString();
                  String wisata = element.data()['total wisata'].toString();
                  String kepadatan =
                      element.data()['total kepadatan'].toString();
                  if (utamaNama.isEmpty) {
                    setState(() {
                      utamaNama = nama;
                      utamaRawat = rawat;
                      utamaKonfirmasi = konfirmasi;
                      utamaSembuh = sembuh;
                      utamaMeninggal = meninggal;
                      utamaWisata = wisata;
                      utamaKepadatan = kepadatan;
                      // ignore: avoid_print
                      print(utamaNama);
                    });
                  } else if (utamaNama.isNotEmpty) {
                    setState(() {
                      utamaNama = "";
                      utamaRawat = "";
                      utamaKonfirmasi = "";
                      utamaSembuh = "";
                      utamaMeninggal = "";
                      utamaWisata = "";
                      utamaKepadatan = "";
                    });
                  }
                })
              });
    }

    List<Widget> widgets = [
      SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ambildata();
                // ignore: avoid_print
                print(utamaNama);
              },
              child: const Text("update"),
            ),
            CardHomeUserMain(
              nama: "Provinsi",
              nilai: utamaNama,
              color: Colors.black87,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardHomeUser(
                    nama: "Jumlah dirawat",
                    nilai: utamaRawat,
                    color: Colors.lightGreen),
                CardHomeUser(
                  nama: "jumlah sembuh",
                  nilai: utamaSembuh,
                  color: Colors.lightGreen,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardHomeUser(
                    nama: "jumlah konfirmasi",
                    nilai: utamaKonfirmasi,
                    color: Colors.redAccent),
                CardHomeUser(
                  nama: "jumlah meninggal",
                  nilai: utamaMeninggal,
                  color: Colors.redAccent,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardHomeUser(
                    nama: "jumlah wisata",
                    nilai: utamaWisata,
                    color: Colors.blueAccent),
                CardHomeUser(
                  nama: "jumlah kepadatan penduduk",
                  nilai: utamaKepadatan,
                  color: Colors.blueAccent,
                ),
              ],
            ),
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
                  hasilTahunView = value ?? "2022";
                });
              },
              selectedItem: "2022",
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
                                width: 40,
                                height: 60,
                                padding: const EdgeInsets.only(right: 12),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1, color: Colors.white)),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Icons.list_alt_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                            title: Text(
                              "Provinsi : ${documentSnapshot['nama']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            // subtitle: Text(
                            //   documentSnapshot['tahun'].toString(),
                            //   style: const TextStyle(color: Colors.white),
                            // ),
                            subtitle: RichText(
                                text: TextSpan(
                                    text:
                                        "tahun : ${documentSnapshot['tahun'].toString()}",
                                    style: const TextStyle(color: Colors.white),
                                    children: [
                                  TextSpan(
                                      text:
                                          "\n   total dirawat : ${documentSnapshot['total rawat'].toString()}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text:
                                              "\n   total konfirmasi : ${documentSnapshot['total konfirmasi'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        TextSpan(
                                          text:
                                              "\n   total sembuh : ${documentSnapshot['total sembuh'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        TextSpan(
                                          text:
                                              "\n   total meninggal : ${documentSnapshot['total meninggal'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        TextSpan(
                                          text:
                                              "\n   total wisatawan per tahun : ${documentSnapshot['total wisata'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        TextSpan(
                                          text:
                                              "\n   total kepadatan penduduk : ${documentSnapshot['total kepadatan'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ])
                                ])),
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
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
      ListView(
        children: [
          const SizedBox(height: 20),
          DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
            ),
            items: data2,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Bulan",
                hintText: "Bulan yang dipilih",
              ),
            ),
            onChanged: (value) {
              // ignore: avoid_print
              print(value);
              setState(() {
                hasilBulanView = value ?? "juli";
              });
            },
            selectedItem: "Juli",
          ),
          const SizedBox(height: 40),
          StreamBuilder(
            stream: users
                .where(
                  'bulan',
                  isEqualTo: hasilBulanView,
                )
                .where('tahun', isEqualTo: 2022)
                .orderBy('hasil SAW', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
              if (streamsnapshot.hasData) {
                return SizedBox(
                  height: 400,
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
                          title: Text(
                            "Provinsi : ${documentSnapshot['nama']}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Bulan : ${documentSnapshot['bulan']}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            documentSnapshot['hasil SAW'].toString(),
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
        ],
      ),
      Center(
          child: Card(
        elevation: 50,
        shadowColor: Colors.grey.shade700,
        color: Colors.black,
        margin: const EdgeInsets.all(60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            text: const TextSpan(
                text:
                    "pembuat aplikasi daerah rawan covid ini adalah saya, kristianto. lahir di bangka belitung dan menetap dibogor. beruniversitas di universitas pakuan dan membuat aplikasi ini sebagai syarat kelulusan skripsi. saya harap aplikasi sederhana ini dapat membantu untuk membagikan data penyebaran covid yang menggunakan metode SAW dan TOPSIS.",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      )),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Daerah Rawan Covid"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignInPage();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: widgets[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 5,
            padding: const EdgeInsets.all(5),
            onTabChange: (index) {
              // ignore: avoid_print
              print(index);
              setState(() {
                currentIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: "home",
              ),
              GButton(
                icon: Icons.leaderboard_outlined,
                text: "perangkingan",
              ),
              GButton(
                icon: Icons.info_outline,
                text: "about",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
