class FlightModel {
  final String airline;
  final String logo;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final int price;
  final List<String> stops;

  FlightModel({
    required this.airline,
    required this.logo,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.stops,
  });
}
