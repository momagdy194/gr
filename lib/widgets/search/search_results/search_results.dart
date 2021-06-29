
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/bloc/profile/profile_bloc.dart';
import 'package:untitled2/bloc/search/search_bloc.dart';
import 'package:untitled2/models/search/search.dart';
import 'package:untitled2/widgets/profile/profile.dart';

class SearchResultsWidget extends StatelessWidget {

  final StockSearch search;

  SearchResultsWidget({
    @required this.search
  });
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.search),
      title: Text(search.symbol),
      onTap: () {

        Navigator
        .push(context, MaterialPageRoute(builder: (_) => Profile( symbol: search.symbol)));

        // Save event.
        BlocProvider
        .of<SearchBloc>(context)
        .add(SaveSearch(symbol: search.symbol));

        // Fetch profile event.
        BlocProvider
        .of<ProfileBloc>(context)
        .add(FetchProfileData(symbol: search.symbol));
      },
    );
  }
}