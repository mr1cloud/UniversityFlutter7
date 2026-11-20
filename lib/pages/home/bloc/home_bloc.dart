import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mock/features_data.dart' as features_data;
import '../../../models/feature.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadFeaturesEvent>(_onLoadFeatures);
  }

  Future<void> _onLoadFeatures(
    LoadFeaturesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(HomeLoaded(features: features_data.features, images: features_data.images));
    } catch (_) {
      emit(const HomeError('Не удалось загрузить данные'));
    }
  }
}
