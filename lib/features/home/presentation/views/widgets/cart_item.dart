import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fruits_hub/core/widgets/custom_network_image.dart';
import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';
import 'package:fruits_hub/features/home/presentation/manager/cubits/cart_cubit/cart_cubit.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartItemEntity});

  final CartItemEntity cartItemEntity;

  @override
  State<CartItem> createState() => _CartItemState();
}

enum ParticleShape { circle, square, triangle }

class _DissolveParticle {
  double x;
  double y;
  final Color color;
  final double size;
  double speedX;
  double speedY;
  double opacity;
  double rotation;
  final ParticleShape shape;

  _DissolveParticle({
    required this.x,
    required this.y,
    required this.color,
    required this.size,
    required this.speedX,
    required this.speedY,
    this.opacity = 1.0,
    this.rotation = 0.0,
    this.shape = ParticleShape.circle,
  });

  void update() {
    x += speedX;
    y += speedY;
    speedY += 0.15;
    opacity -= 0.015;
    rotation += 0.05;
  }
}

class _CartItemState extends State<CartItem> with TickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 100);
  static const _particleCount = 200;
  static const _imageSize = 100.0;
  static const _imageHeight = 110.0;
  static const _horizontalPadding = 17.0;
  static const _verticalSpacing = 8.0;
  static const _counterSpacing = 16.0;
  static const _avatarRadius = 12.0;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final List<_DissolveParticle> _particles = [];
  final math.Random _random = math.Random();
  final GlobalKey _itemKey = GlobalKey();
  Offset _wiggleOffset = Offset.zero;

  Ticker? _wiggleTicker;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuart,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuart,
      ),
    );

    _animationController.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      context.read<CartCubit>().removeCartItem(widget.cartItemEntity);
      _particles.clear();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _wiggleTicker?.dispose();
    super.dispose();
  }

  void _startWiggleEffect(VoidCallback onComplete) {
    final wiggleOffsets = [
      const Offset(0, 0),
      const Offset(2, 0),
      const Offset(-2, 0),
      const Offset(2, 0),
      const Offset(-2, 0),
      const Offset(0, 0),
    ];

    int currentIndex = 0;

    _wiggleTicker?.dispose();

    _wiggleTicker = createTicker((elapsed) {
      if (currentIndex < wiggleOffsets.length) {
        setState(() {
          _wiggleOffset = wiggleOffsets[currentIndex];
        });
        currentIndex++;
      } else {
        _wiggleTicker?.stop();
        setState(() {
          _wiggleOffset = Offset.zero;
        });
        onComplete();
      }
    });

    _wiggleTicker!.start();
  }

  void _startDissolvingEffect() {
    final RenderBox? renderBox =
        _itemKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      _animationController.forward();
      return;
    }

    final widgetSize = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    _createParticles(widgetSize, position);

    _startWiggleEffect(() {
      _animationController.forward(from: 0.0);
    });
  }

  void _createParticles(Size widgetSize, Offset position) {
    _particles.clear();

    final baseColors = [
      AppColors.secondaryColor,
      Colors.white,
      const Color(0xFFF3F5F7),
      Colors.grey.shade300,
    ];

    for (int i = 0; i < _particleCount; i++) {
      final x = position.dx + _random.nextDouble() * widgetSize.width;
      final y = position.dy + _random.nextDouble() * widgetSize.height;

      final color = baseColors[_random.nextInt(baseColors.length)];

      final angle = _random.nextDouble() * math.pi * 2;
      final speed = _random.nextDouble() * 8 + 2;
      final speedX = math.cos(angle) * speed;
      final speedY = math.sin(angle) * speed - 2;

      final particleSize = _random.nextDouble() * 8 + 2;
      final shapeIndex = _random.nextInt(ParticleShape.values.length);
      final shape = ParticleShape.values[shapeIndex];

      _particles.add(_DissolveParticle(
        x: x,
        y: y,
        color: color,
        size: particleSize,
        speedX: speedX,
        speedY: speedY,
        rotation: _random.nextDouble() * math.pi * 2,
        shape: shape,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          current is CartItemUpdated ||
          current is CartItemAdded ||
          current is CartItemRemoved,
      builder: (context, state) {
        return Stack(
          children: [
            _buildDismissibleCartItem(),
            if (_animationController.value > 0) _buildParticleEffect(),
          ],
        );
      },
    );
  }

  Widget _buildDismissibleCartItem() {
    return Dismissible(
      key: ObjectKey(widget.cartItemEntity),
      direction: DismissDirection.startToEnd,
      background: _buildDismissBackground(),
      confirmDismiss: (direction) async {
        _startDissolvingEffect();
        return false;
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: Transform.translate(
          offset: _wiggleOffset,
          child: _buildCartItemContent(),
        ),
      ),
    );
  }

  Widget _buildCartItemContent() {
    return Row(
      key: _itemKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: _horizontalPadding),
          child: Container(
            width: _imageSize,
            height: _imageHeight,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F5F7),
            ),
            child: _buildProductImage(),
          ),
        ),
        const SizedBox(width: _horizontalPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductHeader(),
              const SizedBox(height: _verticalSpacing),
              _buildWeightText(),
              const SizedBox(height: 16),
              _buildQuantityRow(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildProductImage() {
    final imageUrl = widget.cartItemEntity.productEntity.imageUrl;
    return imageUrl != null
        ? CustomNetworkImage(imageUrl: imageUrl)
        : const Center(child: Icon(Icons.image_not_supported));
  }

  Widget _buildProductHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: _horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.cartItemEntity.productEntity.name,
            style: TextStyles.bold16,
          ),
          GestureDetector(
            onTap: _startDissolvingEffect,
            child: SvgPicture.asset(
              Assets.assetsImagesTrash,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightText() {
    return Text(
      '${widget.cartItemEntity.calculateTotalWeight()} كم',
      textAlign: TextAlign.right,
      style: TextStyles.regular16.copyWith(
        color: AppColors.secondaryColor,
      ),
    );
  }

  Widget _buildQuantityRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context
                .read<CartCubit>()
                .incrementCartItemCount(widget.cartItemEntity);
          },
          child: const CircleAvatar(
            radius: _avatarRadius,
            backgroundColor: Color(0xFF1B5E37),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: FittedBox(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _counterSpacing),
          child: Text(
            '${widget.cartItemEntity.count}',
            textAlign: TextAlign.center,
            style: TextStyles.bold16,
          ),
        ),
        GestureDetector(
          onTap: () {
            context
                .read<CartCubit>()
                .decrementCartItemCount(widget.cartItemEntity);
          },
          child: CircleAvatar(
            radius: _avatarRadius,
            backgroundColor: const Color(0xffF3F5F7),
            child: SvgPicture.asset(
              Assets.assetsImagesMinusIcon,
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${widget.cartItemEntity.calculateTotalPrice()} جنيه',
                  style: TextStyles.bold16.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20.0),
      color: Colors.red,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            'حذف',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticleEffect() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        for (var particle in _particles) {
          particle.update();
        }
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: _ParticlesPainter(particles: _particles),
        );
      },
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<_DissolveParticle> particles;

  _ParticlesPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      if (particle.opacity <= 0) continue;

      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(particle.x, particle.y);
      canvas.rotate(particle.rotation);

      switch (particle.shape) {
        case ParticleShape.circle:
          canvas.drawCircle(Offset.zero, particle.size, paint);
          break;
        case ParticleShape.square:
          canvas.drawRect(
              Rect.fromCenter(
                  center: Offset.zero,
                  width: particle.size * 2,
                  height: particle.size * 2),
              paint);
          break;
        case ParticleShape.triangle:
          final path = Path();
          final side = particle.size * 2;
          path.moveTo(0, -side / 2);
          path.lineTo(side / 2, side / 2);
          path.lineTo(-side / 2, side / 2);
          path.close();
          canvas.drawPath(path, paint);
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter oldDelegate) => true;
}
