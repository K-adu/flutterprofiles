import 'package:flutterprofile/models/activity_model.dart';

class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/stmarksbasilica.jpg',
    name: 'Phewa lake and Barahi Mandir tour',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'assets/images/gondola.jpg',
    name: 'Trekking in Annapurna Base Camp',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'assets/images/murano.jpg',
    name: 'Climbing Mount Everest',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/venice.jpg',
    city: 'Pokhara',
    country: 'Nepal',
    description: 'Visit Pokhara for an amazing and unforgettable experience.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/paris.jpg',
    city: 'Jumla',
    country: 'Nepal',
    description: 'Visit Jumla (rara) for a serene experience..',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/newdelhi.jpg',
    city: 'Kathmandu',
    country: 'Nepal',
    description: 'Visit Kathmandu for a religious experience.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/saopaulo.jpg',
    city: 'Chitwan',
    country: 'Nepal',
    description: 'Visit Chitwan for a wildlife experience.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/newyork.jpg',
    city: 'Solukhumbu',
    country: 'Nepal',
    description:
        'Visit Solukhumbu for climbing Mount Everest and enjoying the cold climate.',
    activities: activities,
  ),
];
