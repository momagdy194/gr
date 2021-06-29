import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled2/bloc/sector_performance/sector_performance_bloc.dart';
import 'package:untitled2/models/markets/market_active/market_active_model.dart';

import 'package:untitled2/shared/colors.dart';
import 'package:untitled2/shared/styles.dart';

import 'package:untitled2/widgets/markets/market_movers/market_movers.dart';
import 'package:untitled2/widgets/markets/sector_performance/sector_performance.dart';

import 'package:untitled2/widgets/widgets/empty_screen.dart';
import 'package:untitled2/widgets/widgets/loading_indicator.dart';
import 'package:untitled2/bloc/sector_performance/sector_performance_bloc.dart';

class MarketsPerformance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectorPerformanceBloc, SectorPerformanceState>(
        builder: (BuildContext context, SectorPerformanceState state) {
      if (state is SectorPerformanceInitial) {
        BlocProvider.of<SectorPerformanceBloc>(context)
            .add(FetchSectorPerformance());
      }

      if (state is SectorPerformanceError) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          child: EmptyScreen(message: state.message),
        );
      }

      if (state is SectorPerformanceLoaded) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // Section title.
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: Text('Most Active', style: kSubtitleStyling),
          ),
          _buildMarketMovers(
              stonks: state.marketActive, color: Color(0xFF263497)),

          // Section title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Top Gainers', style: kSubtitleStyling),
          ),
          _buildMarketMovers(stonks: state.marketGainer, color: kPositiveColor),

          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text('Top Losers', style: kSubtitleStyling),
          ),
          _buildMarketMovers(stonks: state.marketLoser, color: Colors.red),
          SectorPerformance(performanceData: state.sectorPerformance),
        ]);
      }

      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        child: LoadingIndicatorWidget(),
      );
    });
  }

  Widget _buildMarketMovers({MarketMoversModelData stonks, Color color}) {
    return Container(
      height: 80,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10),
          scrollDirection: Axis.horizontal,
          itemCount: stonks.marketActiveModelData.length,
          itemBuilder: (BuildContext context, int index) => MarketMovers(
                data: stonks.marketActiveModelData[index],
                color: color,
              )),
    );
  }
}
