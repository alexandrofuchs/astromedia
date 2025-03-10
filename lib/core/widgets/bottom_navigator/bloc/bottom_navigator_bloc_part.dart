part of 'bottom_navigator_bloc.dart';

class NavigationRoute extends NavigationDestination {
  final String route;

  const NavigationRoute({
    required this.route,
    required super.label,
    super.enabled,
    required super.icon,
    super.key,
    super.selectedIcon,
    super.tooltip,
  });
}

enum Status { empty, loaded }

class NavigationState extends Equatable {
  final Map<String, NavigationRoute> navigations;
  final NavigationRoute? current;
  final Status status;
  const NavigationState({
    this.navigations = const {},
    this.current,
    this.status = Status.empty,
  });

  @override
  List<Object?> get props => [status, current];

  NavigationState copyWith({
    NavigationRoute? current,
  }) {
    return NavigationState(
      navigations: navigations,
      status: Status.loaded,
      current: current ?? this.current,
    );
  }
}
