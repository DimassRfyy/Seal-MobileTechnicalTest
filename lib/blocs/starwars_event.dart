import 'package:equatable/equatable.dart';

abstract class StarWarsEvent extends Equatable {
  const StarWarsEvent();
  @override
  List<Object?> get props => [];
}

class FetchCharacters extends StarWarsEvent {}
