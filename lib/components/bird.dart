import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flappy_bird_2/GAME/assets.dart';
import 'package:flappy_bird_2/GAME/bird_movement.dart';
import 'package:flappy_bird_2/GAME/flappy_bird_game.dart';
import 'package:flappy_bird_2/components/configuration.dart';
import 'package:flutter/cupertino.dart';

class Bird extends SpriteGroupComponent<BirdMovement>

  with HasGameRef<FlappyBirdGame> {
    Bird();

    @override
    Future<void> onLoad() async {
      final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
      final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
      final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

      size = Vector2(50, 40);
      position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
      current = BirdMovement.middle;
      sprites = {
        BirdMovement.middle : birdMidFlap,
        BirdMovement.up: birdUpFlap,
        BirdMovement.down: birdDownFlap,
      };
    }
  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Config.gravity as double),
        EffectController(duration: 0.2 , curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
    ),
    );
    current = BirdMovement.up;
  }
  @override
  void update(double dt){
    super.update(dt);
    position.y += Config.birdVelocity * dt;
  }
  }
