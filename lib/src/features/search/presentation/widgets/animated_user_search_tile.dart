import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:aku_task/src/features/search/presentation/widgets/user_search_tile.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimatedUserSearchTile extends StatefulWidget {
  const AnimatedUserSearchTile({
    required this.user,
    this.imageOverride,
    this.enableAnimation = true, // test-friendly toggle
    super.key,
  });

  final UserEntity user;
  final Widget? imageOverride;
  final bool enableAnimation;

  @override
  State<AnimatedUserSearchTile> createState() => _AnimatedUserSearchTileState();
}

class _AnimatedUserSearchTileState extends State<AnimatedUserSearchTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    if (widget.enableAnimation) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransition(
      animation: _animation,
      child: UserSearchTile(
        key: Key(
          'user_tile_${widget.user.id ?? widget.user.email ?? 'unknown'}',
        ),
        user: widget.user,
        imageOverride: widget.imageOverride,
      ),
    );
  }
}
