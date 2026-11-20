part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class LoadFeaturesEvent extends HomeEvent {
  const LoadFeaturesEvent();
}
