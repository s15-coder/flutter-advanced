import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/location/location_bloc.dart';
import 'package:location/blocs/map/map_bloc.dart';
import 'package:location/blocs/search/search_bloc.dart';
import 'package:location/helpers/show_loading_messages.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.showManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          const Positioned(left: 30, top: 50, child: _BackBtn()),
          const Center(
            child: _MarkerCentered(),
          ),
          Positioned(bottom: 30, child: _ConfirmBtn(size: size))
        ],
      ),
    );
  }
}

class _ConfirmBtn extends StatelessWidget {
  const _ConfirmBtn({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.17),
        child: MaterialButton(
          height: 50,
          minWidth: size.width * 0.66,
          onPressed: () async {
            if (locationBloc.state.lastKnownLocation == null) return;
            final start = locationBloc.state.lastKnownLocation!;
            if (mapBloc.mapCenter == null) return;
            final end = mapBloc.mapCenter!;
            showLoadingMessage(context);
            final destination =
                await searchBloc.getCoordsStartToEnd(start, end);
            mapBloc.drawNewPolyline(destination);
            searchBloc.add(OnHideManualMarkerEvent());
            Navigator.pop(context);
          },
          shape: const StadiumBorder(),
          child: const Text(
            'CONFIRM',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: Colors.purple,
        ),
      ),
    );
  }
}

class _MarkerCentered extends StatelessWidget {
  const _MarkerCentered({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: BounceInDown(
        from: 100,
        child: const Icon(
          Icons.location_on_rounded,
          color: Colors.purple,
          size: 50,
        ),
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 500),
      child: CircleAvatar(
        backgroundColor: Colors.purple,
        child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              final searchBloc =
                  BlocProvider.of<SearchBloc>(context, listen: false);
              searchBloc.add(OnHideManualMarkerEvent());
            }),
      ),
    );
  }
}
