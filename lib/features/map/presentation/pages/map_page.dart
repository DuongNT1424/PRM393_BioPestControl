import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../bloc/map_bloc.dart';
import '../bloc/map_event.dart';
import '../bloc/map_state.dart';
import '../widgets/map_card.dart';
import '../../domain/entities/map.dart';
import '../../domain/entities/place.dart';

class MapPage extends StatefulWidget {
  final AuthEntity user;
  const MapPage({super.key, required this.user});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  LatLng? _currentLocation;
  PlaceEntity? _selectedPlace;

  static const LatLng _defaultCenter = LatLng(10.3602, 106.3557);

  LatLng get _fromLocation => _currentLocation ?? _defaultCenter;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      _mapController.move(_currentLocation!, 12);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<MapBloc>()..add(LoadStoreLocationsEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Bản đồ & Cửa hàng',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            actions: [
              IconButton(
                icon: const Icon(Icons.my_location),
                tooltip: 'Vị trí của tôi',
                onPressed: () {
                  if (_currentLocation != null) {
                    _mapController.move(_currentLocation!, 13);
                  } else {
                    _getCurrentLocation();
                  }
                },
              ),
            ],
          ),
          body: BlocConsumer<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapActionFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            buildWhen: (previous, current) =>
                current is MapLoading ||
                current is MapLoaded ||
                current is MapError,
            builder: (context, state) {
              if (state is MapLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primaryColor),
                );
              }

              if (state is MapError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(state.message,
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context
                            .read<MapBloc>()
                            .add(LoadStoreLocationsEvent()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: const Text('Thử lại',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }

              if (state is MapLoaded) {
                return Stack(
                  children: [
                    _buildMap(context, state),
                    _buildSearchArea(context, state),
                    if (state.route != null)
                      _buildRouteInfo(context, state),
                    _buildNearbyStores(context, state),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context, MapLoaded state) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _fromLocation,
        initialZoom: 9,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.prm393_biopestcontrol',
        ),
        if (state.route != null)
          PolylineLayer(
            polylines: [
              Polyline(
                points: state.route!.points,
                strokeWidth: 5,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            if (_currentLocation != null)
              Marker(
                point: _currentLocation!,
                width: 24,
                height: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            if (_selectedPlace != null)
              Marker(
                point: LatLng(
                    _selectedPlace!.latitude, _selectedPlace!.longitude),
                width: 40,
                height: 40,
                child: const Icon(Icons.place,
                    color: Colors.red, size: 40),
              ),
            ...state.stores.map(
              (store) => Marker(
                point: LatLng(store.latitude, store.longitude),
                width: 40,
                height: 40,
                child: GestureDetector(
                  onTap: () => _showStoreSheet(context, store),
                  child: Icon(
                    store.type == 'warehouse'
                        ? Icons.warehouse
                        : Icons.storefront,
                    color: AppColors.primaryColor,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchArea(BuildContext context, MapLoaded state) {
    return Positioned(
      top: 12,
      left: 16,
      right: 16,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 600), () {
                  if (value.trim().isEmpty) {
                    context.read<MapBloc>().add(ClearSearchEvent());
                  } else {
                    context
                        .read<MapBloc>()
                        .add(SearchLocationEvent(value.trim()));
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm địa điểm...',
                hintStyle:
                    const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.primaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _selectedPlace = null);
                          context.read<MapBloc>().add(ClearSearchEvent());
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          if (state.searchResults.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              constraints: const BoxConstraints(maxHeight: 220),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.searchResults.length,
                separatorBuilder: (_, i) => const Divider(height: 1),
                itemBuilder: (ctx, index) {
                  final place = state.searchResults[index];
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.place_outlined,
                        color: AppColors.primaryColor, size: 20),
                    title: Text(
                      place.displayName,
                      style: const TextStyle(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      setState(() => _selectedPlace = place);
                      _mapController.move(
                          LatLng(place.latitude, place.longitude), 14);
                      context.read<MapBloc>().add(ClearSearchEvent());
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context, MapLoaded state) {
    final route = state.route!;
    final distanceKm = (route.distanceMeters / 1000).toStringAsFixed(1);
    final durationMin = (route.durationSeconds / 60).round();

    return Positioned(
      top: 72,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.directions_car, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Đến ${state.directionStore?.name ?? ''}: $distanceKm km • khoảng $durationMin phút',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              onTap: () =>
                  context.read<MapBloc>().add(ClearDirectionEvent()),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyStores(BuildContext context, MapLoaded state) {
    if (state.stores.isEmpty) return const SizedBox.shrink();

    final sortedStores = List<StoreLocationEntity>.from(state.stores);
    sortedStores.sort((a, b) {
      final distanceA = Geolocator.distanceBetween(_fromLocation.latitude,
          _fromLocation.longitude, a.latitude, a.longitude);
      final distanceB = Geolocator.distanceBetween(_fromLocation.latitude,
          _fromLocation.longitude, b.latitude, b.longitude);
      return distanceA.compareTo(distanceB);
    });

    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: sortedStores.length,
          itemBuilder: (ctx, index) {
            final store = sortedStores[index];
            final distance = Geolocator.distanceBetween(
                _fromLocation.latitude,
                _fromLocation.longitude,
                store.latitude,
                store.longitude);
            return StoreCard(
              store: store,
              distanceMeters: distance,
              onTap: () {
                _mapController.move(
                    LatLng(store.latitude, store.longitude), 14);
                _showStoreSheet(context, store);
              },
              onDirection: () => _getDirection(context, store),
            );
          },
        ),
      ),
    );
  }

  void _getDirection(BuildContext context, StoreLocationEntity store) {
    context.read<MapBloc>().add(GetDirectionEvent(
          from: _fromLocation,
          store: store,
        ));
    _mapController.move(_fromLocation, 10);
  }

  Future<void> _openGoogleMaps(StoreLocationEntity store) async {
    final url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=${store.latitude},${store.longitude}');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _showStoreSheet(BuildContext context, StoreLocationEntity store) {
    final mapBloc = context.read<MapBloc>();
    final distance = Geolocator.distanceBetween(_fromLocation.latitude,
        _fromLocation.longitude, store.latitude, store.longitude);
    final distanceText = distance < 1000
        ? '${distance.round()} m'
        : '${(distance / 1000).toStringAsFixed(1)} km';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    store.type == 'warehouse'
                        ? Icons.warehouse_outlined
                        : Icons.storefront_outlined,
                    color: AppColors.primaryColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        store.type == 'warehouse'
                            ? 'Kho hàng • cách $distanceText'
                            : 'Cửa hàng • cách $distanceText',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    store.address,
                    style:
                        TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            if (store.phone != null && store.phone!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.phone_outlined,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    store.phone!,
                    style:
                        TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      mapBloc.add(GetDirectionEvent(
                        from: _fromLocation,
                        store: store,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.directions, size: 18),
                    label: const Text('Chỉ đường'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _openGoogleMaps(store);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side:
                          const BorderSide(color: AppColors.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.map_outlined, size: 18),
                    label: const Text('Google Maps'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
