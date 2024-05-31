import 'package:fl_chart/fl_chart.dart';

class LineData {
  final orderSpots = const [
    ///////Days||Total Orders////
    FlSpot(0, 2),
    FlSpot(10, 10),
    FlSpot(20, 3),
    FlSpot(30, 10),
    FlSpot(40, 19),
    FlSpot(50, 40),
    FlSpot(60, 17),
  ];

  final orderleftTitle = {
    0: '0',
    10: '10',
    20: '20',
    30: '30',
    40: '40',
    50: '50',
  };
  final orderBottomTitle = {
    0: 'Sen',
    10: 'Sel',
    20: 'Rab',
    30: 'Kam',
    40: 'Jum',
    50: 'Sab',
    60: 'Min',
  };

  final transactionSpots = const [
    ///////Days||Total Orders////
    FlSpot(0, 2),
    FlSpot(10, 10),
    FlSpot(20, 3),
    FlSpot(30, 10),
    FlSpot(40, 19),
    FlSpot(50, 40),
    FlSpot(60, 17),
  ];

  final transactionLeftTitle = {
    0: '0',
    10: '10',
    20: '20',
    30: '30',
    40: '40',
    50: '50',
  };
  final transactionBottomTitle = {
    0: 'Januari',
    10: 'Februari',
    20: 'Maret',
    30: 'April',
    40: 'Mei',
    50: 'Juni',
    60: 'Juli',
    70: 'Agustus',
    80: 'September',
    90: 'Oktober',
    100: 'November',
    110: 'Desember',
  };
}
