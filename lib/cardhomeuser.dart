import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardHomeUserMain extends StatelessWidget {
  CardHomeUserMain(
      {Key? key, required this.nama, required this.nilai, required this.color})
      : super(key: key);

  String nama;
  String nilai;
  Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          color: color,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(nama,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  )),
              Text(nilai,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardHomeUser extends StatelessWidget {
  CardHomeUser(
      {Key? key, required this.nama, required this.nilai, required this.color})
      : super(key: key);

  String nama;
  String nilai;
  Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          color: color,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(nama,
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade100,
                  )),
              Text(nilai,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade100,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
