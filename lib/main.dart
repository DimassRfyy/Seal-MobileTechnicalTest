import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/starwars_service.dart';
import 'blocs/starwars_bloc.dart';
import 'ui/starwars_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => StarWarsBloc(StarWarsService()))],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Star Wars Characters',
        home: const StarWarsListPage(),
      ),
    );
  }
}
