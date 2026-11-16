// Copyright (c) 2026 Tayara.
//
// File: lib/presentation/bloc/bx_package_detail_screen_controller/bx_package_detail_screen_controller_event.dart
// Architecture: Presentation Layer - Bx Package Detail Screen Controller
// Purpose: Events for package detail screen BLoC

part of 'bx_package_detail_screen_controller_bloc.dart';

abstract class BxPackageDetailScreenControllerEvent extends Equatable {
  const BxPackageDetailScreenControllerEvent();
  @override
  List<Object?> get props => [];
}

class BxLoadPackageDetail extends BxPackageDetailScreenControllerEvent {
  final int packageId;
  const BxLoadPackageDetail({required this.packageId});
  @override
  List<Object?> get props => [packageId];
}

class BxChangeImage extends BxPackageDetailScreenControllerEvent {
  final int index;
  const BxChangeImage(this.index);
  @override
  List<Object?> get props => [index];
}

class BxSelectDate extends BxPackageDetailScreenControllerEvent {
  final int index;
  const BxSelectDate(this.index);
  @override
  List<Object?> get props => [index];
}

class BxSetUserRating extends BxPackageDetailScreenControllerEvent {
  final int rating;
  const BxSetUserRating(this.rating);
  @override
  List<Object?> get props => [rating];
}

class BxToggleAddOn extends BxPackageDetailScreenControllerEvent {
  final int index;
  const BxToggleAddOn(this.index);
  @override
  List<Object?> get props => [index];
}

class BxSelectCabin extends BxPackageDetailScreenControllerEvent {
  final int index;
  const BxSelectCabin(this.index);
  @override
  List<Object?> get props => [index];
}
