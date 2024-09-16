import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_2/components/background.dart';
import 'package:flappy_bird_2/components/bird.dart';
import 'package:flappy_bird_2/components/configuration.dart';
import 'package:flappy_bird_2/components/pipe_group.dart';

class FlappyBirdGame extends FlameGame with TapDetector{
  FlappyBirdGame();


  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      bird = Bird(),
      PipeGroup(),
    
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  @override
  void onTap(){
    super.onTap();
    bird.fly();
  }
  @override
  void update(double dt){
    super.update(dt);
    interval.update(dt);
  }
}

