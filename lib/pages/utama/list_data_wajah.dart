import 'package:face_net_authentication/helpers/db/database_helper.dart';
import 'package:face_net_authentication/helpers/db/class_siswa.dart';
import 'package:flutter/material.dart';

class ListDataWajah extends StatefulWidget {
  const ListDataWajah({super.key});

  @override
  State<ListDataWajah> createState() => _ListDataWajahState();
}

class _ListDataWajahState extends State<ListDataWajah> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    dbHelper.database;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Data Wajah',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Siswa>>(
            future: dbHelper.queryAllSiswa(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].nmsiswa,
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(Icons.read_more),
                          onTap: () {},
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple.shade800,
                  ),
                );
              }
            }),
      ),
    );
  }
}
