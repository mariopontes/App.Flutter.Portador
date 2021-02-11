import 'package:intl/intl.dart';

class CardExtractModel {
  String establecimento;
  String timestamp;
  String hourSec;
  String tipoTransacao;
  String statusTransacao;
  String valorInterno;

  CardExtractModel.fromJson(Map<String, dynamic> json) {
    establecimento = json['establecimento'];

    tipoTransacao = json['tipo_transacao'];
    statusTransacao = json['status_transacao'];
    valorInterno = json['valor_interno'];

    final DateFormat dt = new DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY, 'pt_BR');
    timestamp = dt.format(DateTime.fromMillisecondsSinceEpoch(int.parse(json['timestamp']) * 1000));

    final DateFormat dt2 = new DateFormat('HH:ss');
    hourSec = dt2.format(DateTime.fromMillisecondsSinceEpoch(int.parse(json['timestamp']) * 1000));
  }

  // ${DateTime.fromMillisecondsSinceEpoch(int.parse(snapshot.data[index].timestamp) * 1000)}

}
