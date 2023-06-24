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
      body: FutureBuilder<List<Siswa>>(
          future: dbHelper.queryAllSiswa(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].modelData.toString()),
                      subtitle: Text(snapshot.data![index].nmsiswa),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              );
            }
          }),
    );
  }
}
