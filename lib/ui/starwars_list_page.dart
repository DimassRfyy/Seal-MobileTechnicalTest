import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import '../blocs/starwars_bloc.dart';
import '../blocs/starwars_event.dart';
import '../blocs/starwars_state.dart';
import '../shared/theme.dart';

class StarWarsListPage extends StatelessWidget {
  const StarWarsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const SpaceBackground(),

          BlocBuilder<StarWarsBloc, StarWarsState>(
            builder: (context, state) {
              if (state is StarWarsLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: kYellow),
                );
              } else if (state is StarWarsLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      final character = state.characters[index];
                      return Card(
                        color: kYellow.withAlpha((0.9 * 255).round()),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            character.name,
                            style: kSubtitleStyle.copyWith(
                              color: kBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Gender: ${character.gender} | Height: ${character.height} cm',
                            style: kBodyStyle.copyWith(color: kBlack),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: kBlack,
                            size: 16,
                          ),
                          onTap:
                              () => _showCharacterDetails(context, character),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is StarWarsError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      state.message,
                      style: kBodyStyle.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: kYellow.withAlpha((0.3 * 255).round()),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://img.icons8.com/color/512/star-wars.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: kYellow.withAlpha((0.2 * 255).round()),
                              child: const Icon(
                                Icons.star,
                                size: 100,
                                color: kYellow,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kYellow,
                        foregroundColor: kBlack,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 8,
                      ),
                      onPressed:
                          () => context.read<StarWarsBloc>().add(
                            FetchCharacters(),
                          ),
                      child: const Text(
                        'Load Characters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCharacterDetails(BuildContext context, dynamic character) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: kBlack.withAlpha((0.95 * 255).round()),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kYellow, width: 2),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        character.name,
                        style: kTitleStyle.copyWith(
                          color: kYellow,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: kYellow),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _buildDetailRow(
                  'Height',
                  (character.height != null && character.height != 'unknown' && character.height != '')
                      ? '${character.height} cm'
                      : 'Unknown',
                ),
                _buildDetailRow('Mass', character.mass ?? 'Unknown'),
                _buildDetailRow('Hair Color', character.hairColor ?? 'Unknown'),
                _buildDetailRow('Skin Color', character.skinColor ?? 'Unknown'),
                _buildDetailRow('Eye Color', character.eyeColor ?? 'Unknown'),
                _buildDetailRow('Birth Year', character.birthYear ?? 'Unknown'),
                _buildDetailRow('Gender', character.gender ?? 'Unknown'),

                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kYellow,
                      foregroundColor: kBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: kBodyStyle.copyWith(
                color: kYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: kBodyStyle.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Custom Space Background Widget
class SpaceBackground extends StatefulWidget {
  const SpaceBackground({Key? key}) : super(key: key);

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> stars = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Generate random stars
    for (int i = 0; i < 100; i++) {
      stars.add(
        Star(
          x: math.Random().nextDouble(),
          y: math.Random().nextDouble(),
          size: math.Random().nextDouble() * 3 + 1,
          opacity: math.Random().nextDouble() * 0.8 + 0.2,
          twinkleSpeed: math.Random().nextDouble() * 2 + 1,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [const Color(0xFF0D1B2A), const Color(0xFF1B263B), kBlack],
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: StarsPainter(stars, _controller.value),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double twinkleSpeed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.twinkleSpeed,
  });
}

class StarsPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarsPainter(this.stars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (final star in stars) {
      final x = star.x * size.width;
      final y = star.y * size.height;

      // Calculate twinkling effect
      final twinkle =
          (math.sin(animationValue * 2 * math.pi * star.twinkleSpeed) + 1) / 2;
      final currentOpacity = star.opacity * twinkle;

      paint.color = Colors.white.withAlpha((currentOpacity * 255).round());

      canvas.drawCircle(Offset(x, y), star.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
