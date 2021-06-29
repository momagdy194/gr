import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/bloc/search/search_bloc.dart';
import 'package:untitled2/shared/colors.dart';

class SearchBoxWidget extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return ListView(

      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),

      children: <Widget>[
        Container(
          height: 46,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
         border: Border.all(color: Colors.white),
            color:kScaffoldBackground // Theme.of(context).scaffoldBackgroundColor,
          ),
    
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.search),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 15.5),
                    border: InputBorder.none,
                  ),

                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      BlocProvider
                      .of<SearchBloc>(context)
                      .add(FetchSearchResults(symbol: value.toUpperCase()));
                    } else {
                      BlocProvider
                      .of<SearchBloc>(context)
                      .add(FetchSearchHistory());
                    }
                  }
                )
              ),
            ]
          )
        ),
      ],
    );
  }
}
