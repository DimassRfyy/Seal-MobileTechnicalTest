import 'package:flutter_bloc/flutter_bloc.dart';
import 'starwars_event.dart';
import 'starwars_state.dart';
import '../services/starwars_service.dart';

class StarWarsBloc extends Bloc<StarWarsEvent, StarWarsState> {
  final StarWarsService service;
  StarWarsBloc(this.service) : super(StarWarsInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(StarWarsLoading());
      try {
        final characters = await service.fetchCharacters();
        emit(StarWarsLoaded(characters));
      } catch (e) {
        emit(StarWarsError(e.toString()));
      }
    });
  }
}
