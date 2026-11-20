part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required this.features, required this.images});

  final List<Feature> features;
  final List<String> images;
}

final class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;
}
