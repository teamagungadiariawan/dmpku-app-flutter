import 'package:dmpku/model/product_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransaksiProsesState extends Equatable {
  final ImageProvider? image;
  final ProductModel product;
  final int potongStok;
  final String tujuan;
  final String waktuTransaksi;

  TransaksiProsesState({
    this.image,
    this.product = DEFAULT_PRODUCT,
    this.potongStok = 0,
    this.tujuan = '',
    this.waktuTransaksi = '',
  });

  TransaksiProsesState copyWith({
    ImageProvider? image,
    ProductModel? product,
    int? potongStok,
    String? tujuan,
    String? waktuTransaksi,
  }) {
    return TransaksiProsesState(
      image: image ?? this.image,
      product: product ?? this.product,
      potongStok: potongStok ?? this.potongStok,
      tujuan: tujuan ?? this.tujuan,
      waktuTransaksi: waktuTransaksi ?? this.waktuTransaksi,
    );
  }

  @override
  List<Object?> get props => [
    image,
    product,
    potongStok,
    tujuan,
    waktuTransaksi,
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
}

TransaksiProsesProvider getTransaksiProsesProvider(BuildContext context) {
  return context.read<TransaksiProsesProvider>();
}
