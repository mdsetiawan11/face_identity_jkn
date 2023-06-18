import 'dart:convert';

class Siswa {
  String idsiswa;
  String nmsiswa;
  List modelData;

  Siswa({
    required this.idsiswa,
    required this.nmsiswa,
    required this.modelData,
  });

  static Siswa fromMap(Map<String, dynamic> siswa) {
    return new Siswa(
      idsiswa: siswa['idsiswa'],
      nmsiswa: siswa['nmsiswa'],
      modelData: jsonDecode(siswa['model_data']),
    );
  }

  toMap() {
    return {
      'idsiswa': idsiswa,
      'nmsiswa': nmsiswa,
      'model_data': jsonEncode(modelData),
    };
  }
}
