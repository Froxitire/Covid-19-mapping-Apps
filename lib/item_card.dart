import 'package:flutter/material.dart';

class ItemKartu extends StatelessWidget {
  final String nama;
  final String umur;
  //// Pointer to Update Function
  // final Function onUpdate;
  //// Pointer to Delete Function
  // final Function onDelete;

  // ignore: use_key_in_widget_constructors
  const ItemKartu(this.nama, this.umur);
  // {this.onUpdate, this.onDelete}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueAccent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(nama),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(umur),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                    child: const Center(
                        child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      // onUpdate();
                    }),
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                    child: const Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      // onDelete();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
