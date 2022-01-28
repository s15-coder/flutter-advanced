import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/blocs/gps/gps_bloc.dart';

class AccessLocationPage extends StatefulWidget {
  const AccessLocationPage({Key? key}) : super(key: key);
  static const routeName = '/AccessLocationPage';

  @override
  State<AccessLocationPage> createState() => _AccessLocationPageState();
}

class _AccessLocationPageState extends State<AccessLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          print(state);
          if (state.isGpsEnabled) {
            return const _AccessButton();
          } else {
            return const _EnableGpsText();
          }
        },
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gpsBloc = BlocProvider.of<GpsBloc>(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('The location access is required'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          MaterialButton(
            shape: const StadiumBorder(),
            color: Colors.black,
            onPressed: gpsBloc.requestGpsAccess,
            child: const Text(
              'Request access',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class _EnableGpsText extends StatelessWidget {
  const _EnableGpsText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Debes habilitar el GPS'),
    );
  }
}
