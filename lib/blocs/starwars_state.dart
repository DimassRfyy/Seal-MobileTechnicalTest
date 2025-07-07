import 'package:equatable/equatable.dart';
import '../models/character_model.dart';

abstract class StarWarsState extends Equatable {
  const StarWarsState();
  @override
  List<Object?> get props => [];
}

class StarWarsInitial extends StarWarsState {}

class StarWarsLoading extends StarWarsState {}

class StarWarsLoaded extends StarWarsState {
  final List<Character> characters;
  const StarWarsLoaded(this.characters);
  @override
  List<Object?> get props => [characters];
}

class StarWarsError extends StarWarsState {
  final String message;
  const StarWarsError(this.message);
  @override
  List<Object?> get props => [message];
}
