import 'package:weather/models/city.dart';
import 'package:weather/services/network/openweather.dart';
import 'package:flutter/material.dart';

class SearchCityScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, "");
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ""),
      );

  @override
  Widget buildResults(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<City>>(
          future: OpenWeather.searchCities(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data!.isEmpty) {
              return buildNoSuggestions();
            }
            return buildSuggestionsOrResults(snapshot.data!);
          },
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List<City>>(
        future: OpenWeather.searchCities(query: query),
        builder: (context, snapshot) {
          if (query.isEmpty) return buildNoSuggestions();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data!.isEmpty) {
            return buildNoSuggestions();
          }
          return buildSuggestionsOrResults(snapshot.data!);
        },
      );

  Widget buildNoSuggestions() => const Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.black),
        ),
      );

  Widget buildSuggestionsOrResults(List<City> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            onTap: () {
              // Close Search & Return Result
              close(context, suggestion.city);
            },
            leading: const Icon(Icons.location_city),
            title: Text(
              suggestion.city,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${suggestion.state},${suggestion.country}"),
          );
        },
      );
}
