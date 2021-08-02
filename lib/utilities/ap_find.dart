import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flyfi/notifiers/ap_table_controller.dart';

findAP() {
  ApTableController.instance.clear();
  ApTableController.instance.searchingAp();
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 10001)
      .then((RawDatagramSocket s) {
    Timer(Duration(seconds: 5), () {
      s.close();
      print(
          '[LOG] Lista de APs encontrados${ApTableController.instance.apsList}');
      print('[LOG] Socket encerrado');
      ApTableController.instance.searchingAp();
    });
    s.send(ascii.encode('ping'), new InternetAddress("233.89.188.1"), 10001);
    s.joinMulticast(new InternetAddress("233.89.188.1"));
    s.listen((RawSocketEvent e) {
      final dg = s.receive();
      if (dg == null || dg.address.address == InternetAddress.anyIPv4.address) {
        print("Discarding null datagram.");
        return;
      }
      final data = dg.data;
      var apInfo = {'mac': '', 'model': '', 'ip': dg.address.address};
      var controleLoop = 0;
      for (var byte in data) {
        if (controleLoop > 1 && controleLoop < 8) {
          //encontra o mac
          apInfo['mac'] = apInfo['mac']! == ''
              ? byte.toRadixString(16)
              : apInfo['mac']! + ':' + byte.toRadixString(16);
        }
        if (controleLoop >= 16) {
          //Do 16º byte para frente, é o modelo+versão do dispositivo.
          final regexp = RegExp(r'^[a-zA-Z0-9.\w ]');
          var decode = utf8.decode([byte], allowMalformed: true);
          if (regexp.stringMatch(decode.toString()) == decode.toString() ||
              byte.toRadixString(16) == '0') {
            //Verifica se após passar pelo Regex, resulta na própria letra,
            //indicando ser um caractere válido. Além disso, verifica se o byte
            // é 0, a fim de usá-lo como um caractere de espaço.
            apInfo['model'] = byte.toRadixString(16) == '0'
                ? '${apInfo['model']} '
                : '${apInfo['model']}$decode';
          }
        }

        controleLoop++;
      }
      if (apInfo['mac']!.compareTo('') != 0 &&
          apInfo['model']!.compareTo('') != 0 &&
          apInfo['ip']!.compareTo('') != 0) {
        ApTableController.instance.addAp(apInfo);
      }

      print(
          'Dispositivo encontrado!\nModelo: ${apInfo['model']}\nMAC: ${apInfo['mac']}\nIP: ${apInfo['ip']}');
    });
  });
}
