
// ignore_for_file: non_constant_identifier_names

String getMapUrls(double lat, double lng) {
 return 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
}

String getMapGeoLocation({latitude,longitude,GOOGLE_API_KEY}){
 return "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY";
}
