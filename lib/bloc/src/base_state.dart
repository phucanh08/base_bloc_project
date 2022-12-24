import 'package:flutter/material.dart';

class CommonStatus {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isEmpty;
  final bool isLoadingMore;
  final String? errorMessage;

  CommonStatus._({
    this.isEmpty = false,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isLoadingMore = false,
  });

  const CommonStatus.loading({
    this.isEmpty = false,
    this.isLoading = true,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isLoadingMore = false,
  });

  factory CommonStatus.loadingMore() {
    return CommonStatus._(isSuccess: true, isLoadingMore: true);
  }

  factory CommonStatus.success() {
    return CommonStatus._(isSuccess: true);
  }

  factory CommonStatus.error([String? message]) {
    return CommonStatus._(isError: true, errorMessage: message);
  }

  factory CommonStatus.empty() {
    return CommonStatus._(isEmpty: true);
  }
}

abstract class BaseState {
  final List<ValueKey> ids;
  final CommonStatus status;

  const BaseState({
    this.ids = const [],
    this.status = const CommonStatus.loading(),
  });

  BaseState copyWith({List<ValueKey> listIdUpdate, CommonStatus? status});
}
