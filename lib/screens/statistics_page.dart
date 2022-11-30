import 'package:basic_todo_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    final int totalTodo = ref.read(todoNotifierProvider.notifier).length;
    final int checkedTodo =
        ref.read(todoNotifierProvider.notifier).checkedTodos;
    final int onGoingTodo = totalTodo - checkedTodo;
    final percantage = ((checkedTodo / totalTodo) * 100).round();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Total Todo\'s',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(totalTodo.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.blue)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Ongoing Todo\'s',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(onGoingTodo.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.red)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Ended Todo\'s',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(checkedTodo.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.green)),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CircularPercentIndicator(
                  radius: 150,
                  percent: checkedTodo / totalTodo,
                  lineWidth: 20.0,
                  progressColor: getColor(checkedTodo / totalTodo),
                  animation: true,
                  animationDuration: 1000,
                  backgroundWidth: 10,
                  center: Text(
                    '% ${percantage.toString()}',
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

getColor(double percentage) {
  if (percentage <= 0.25) {
    return Colors.red;
  } else if (percentage > 0.25 && percentage <= 0.75) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}
