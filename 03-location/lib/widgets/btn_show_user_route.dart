import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';

class BtnShowUserRoute extends StatelessWidget {
  const BtnShowUserRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => mapBloc.add(OnToggleShowUserRouteEvent()),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.purple,
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.account_tree_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
