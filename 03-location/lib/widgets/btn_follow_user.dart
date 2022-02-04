import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              if (!state.followUser) {
                mapBloc.add(OnStartFollowingUserEvent());
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                state.followUser
                    ? Icons.directions_run_outlined
                    : Icons.follow_the_signs,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
