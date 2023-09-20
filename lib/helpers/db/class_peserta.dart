import 'dart:convert';

class Peserta {
  String nik;
  List modelData;

  Peserta({
    required this.nik,
    required this.modelData,
  });

  static Peserta fromMap(Map<String, dynamic> listpeserta) {
    return new Peserta(
      nik: listpeserta['nik'],
      modelData: jsonDecode(listpeserta['model_data']),
    );
  }

  toMap() {
    return {
      'nik': nik,
      'model_data': jsonEncode(modelData),
    };
  }
}
