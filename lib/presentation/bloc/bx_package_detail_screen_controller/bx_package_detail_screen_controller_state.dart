// Copyright (c) 2026 Tayara.
//
// File: lib/presentation/bloc/bx_package_detail_screen_controller/bx_package_detail_screen_controller_state.dart
// Architecture: Presentation Layer - Bx Package Detail Screen Controller
// Purpose: State class for package detail screen BLoC

part of 'bx_package_detail_screen_controller_bloc.dart';

enum BxPackageDetailScreenControllerStatus {
  initial,
  loading,
  success,
  failure,
}

class BxPackageDetailScreenControllerState extends Equatable {
  final int packageId;
  final BxPackageDetailScreenControllerStatus status;
  final BxGetPackageDetailResponse? packageDetail;

  // ── Ephemeral UI state (previously held in StatefulWidget) ──
  final int currentImageIndex;
  final int selectedDateIndex;
  final int userRating;
  final List<int> selectedAddOns;
  final int selectedCabinIndex;

  const BxPackageDetailScreenControllerState({
    this.packageId = 0,
    this.status = BxPackageDetailScreenControllerStatus.initial,
    this.packageDetail,
    this.currentImageIndex = 0,
    this.selectedDateIndex = 0,
    this.userRating = 0,
    this.selectedAddOns = const [],
    this.selectedCabinIndex = 0,
  });

  BxPackageDetailScreenControllerState copyWith({
    int? packageId,
    BxPackageDetailScreenControllerStatus? status,
    BxGetPackageDetailResponse? packageDetail,
    int? currentImageIndex,
    int? selectedDateIndex,
    int? userRating,
    List<int>? selectedAddOns,
    int? selectedCabinIndex,
  }) {
    return BxPackageDetailScreenControllerState(
      packageId: packageId ?? this.packageId,
      status: status ?? this.status,
      packageDetail: packageDetail ?? this.packageDetail,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      selectedDateIndex: selectedDateIndex ?? this.selectedDateIndex,
      userRating: userRating ?? this.userRating,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      selectedCabinIndex: selectedCabinIndex ?? this.selectedCabinIndex,
    );
  }

  @override
  List<Object?> get props => [
    packageId,
    status,
    packageDetail,
    currentImageIndex,
    selectedDateIndex,
    userRating,
    selectedAddOns,
    selectedCabinIndex,
  ];
}
