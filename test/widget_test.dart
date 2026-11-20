import 'package:flutter_test/flutter_test.dart';

import 'package:university_flutter_7/pages/home/bloc/home_bloc.dart';

void main() {
  test('HomeBloc: initial -> loading -> loaded', () async {
    final bloc = HomeBloc();
    expect(bloc.state, isA<HomeInitial>());

    final states = <HomeState>[];
    final sub = bloc.stream.listen(states.add);

    bloc.add(const LoadFeaturesEvent());
    await Future.delayed(const Duration(milliseconds: 700));

    expect(states.first, isA<HomeLoading>());
    expect(states.last, isA<HomeLoaded>());
    expect((states.last as HomeLoaded).features, isNotEmpty);

    await sub.cancel();
    await bloc.close();
  });
}
