String _base() {
  const sil = 'https://';
  const ros = 'debug';
  const mau = '.';
  const sher = 'mit';
  const fir = 'ra';
  const rah = 'kon';
  const bung = 'ter.';
  const yun = 'com';
  final bsrl = [sil, ros, mau, sher, fir, rah, bung, yun].join('');
  return bsrl;
}

String _baseReg() {
  const sil = 'https://';
  const ros = 'regional';
  const mau = '.';
  const sher = 'mit';
  const fir = 'ra';
  const rah = 'kon';
  const bung = 'ter.';
  const yun = 'com';
  final bsrl = [sil, ros, mau, sher, fir, rah, bung, yun].join('');
  return bsrl;
}

final String baseUrl = _base();
final String baseUrlCallback = _baseReg();
