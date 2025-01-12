import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird_2/GAME/flappy_bird_game.dart';
import 'package:flappy_bird_2/GAME/pipe_position.dart';
import 'package:flappy_bird_2/components/configuration.dart';
import 'package:flappy_bird_2/components/pipe.dart';
import 'package:flutter/foundation.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame>{
  PipeGroup();

  final _random = Random();
  
  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);
    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
       Pipe(
        pipePosition: PipePosition.bottom,
         height: heightMinusGround - (centerY + spacing / 2)),
    ]);
  }

  @override
  void update(double dt){
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if(position.x < -10){
      removeFromParent();
      debugPrint("removed");
    }
  }
}
