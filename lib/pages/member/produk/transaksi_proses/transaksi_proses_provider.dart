import 'package:dmpku/model/product_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProsesTrxBanyak {
  final String tujuan;
  final bool success;

  const ProsesTrxBanyak({required this.tujuan, required this.success});

  ProsesTrxBanyak copyWith({String? tujuan, bool? success}) {
    return ProsesTrxBanyak(
      tujuan: tujuan ?? this.tujuan,
      success: success ?? this.success,
    );
  }

  @override
  String toString() {
    return 'ProsesTrxBanyak(tujuan: $tujuan, success: $success)';
  }
}

class TransaksiProsesState extends Equatable {
  final ImageProvider? image;
  final ProductModel product;
  final int potongStok;
  final String tujuan;
  final String waktuTransaksi;
  final List<ProsesTrxBanyak> tujuanHistory;

  TransaksiProsesState({
    this.image,
    this.product = DEFAULT_PRODUCT,
    this.potongStok = 0,
    this.tujuan = '',
    this.waktuTransaksi = '',
    this.tujuanHistory = const [],
  });

  TransaksiProsesState copyWith({
    ImageProvider? image,
    ProductModel? product,
    int? potongStok,
    String? tujuan,
    String? waktuTransaksi,
    List<ProsesTrxBanyak>? tujuanHistory,
  }) {
    return TransaksiProsesState(
      image: image ?? this.image,
      product: product ?? this.product,
      potongStok: potongStok ?? this.potongStok,
      tujuan: tujuan ?? this.tujuan,
      waktuTransaksi: waktuTransaksi ?? this.waktuTransaksi,
      tujuanHistory: tujuanHistory ?? this.tujuanHistory,
    );
  }

  @override
  List<Object?> get props => [
    image,
    product,
    potongStok,
    tujuan,
    waktuTransaksi,
    tujuanHistory,
  ];
}

class TransaksiProsesProvider extends Cubit<TransaksiProsesState> {
  TransaksiProsesProvider() : super(TransaksiProsesState());

  @override
  Future<void> close() {
    return super.close();
  }

  void setImage(ImageProvider image) {
    emit(state.copyWith(image: image));
  }

  void setProduct(ProductModel product) {
    emit(state.copyWith(product: product));
  }

  void setPotongStok(int potongStok) {
    emit(state.copyWith(potongStok: potongStok));
  }

  void setTujuan(String tujuan) {
    emit(state.copyWith(tujuan: tujuan));
  }

  void setWaktuTransaksi(String waktuTransaksi) {
    emit(state.copyWith(waktuTransaksi: waktuTransaksi));
  }

  void setTujuanHistory(List<ProsesTrxBanyak> tujuanHistory) {
    emit(state.copyWith(tujuanHistory: tujuanHistory));
  }
}

TransaksiProsesProvider getTransaksiProsesProvider(BuildContext context) {
  return context.read<TransaksiProsesProvider>();
}
