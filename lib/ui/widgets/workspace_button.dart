import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/ui/providers/utils_providers/home_destinations_provider.dart';

class WorkspaceButton extends ConsumerStatefulWidget {
  const WorkspaceButton({super.key});

  @override
  ConsumerState<WorkspaceButton> createState() => _WorkspaceButtonState();
}

class _WorkspaceButtonState extends ConsumerState<WorkspaceButton>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showDropdown();
    } else {
      _hideDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
  }

  void _hideDropdown() async {
    await _controller.reverse();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final textTheme = Theme.of(context).textTheme;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 600,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 4),
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                alignment: Alignment.topCenter,
                child: Consumer(
                  builder: (context, ref, _) {
                    return Card(
                      child: SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Заголовок",
                                style: textTheme.titleLarge,
                              ),
                              const Divider(),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: const Text("Workspace 1"),
                                      onTap: () {
                                        ref
                                            .read(homeDestinationsProvider
                                                .notifier)
                                            .navigateToWorkspaces();
                                        _hideDropdown();
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: ElevatedButton(
        onLongPress: () {
          ref.read(homeDestinationsProvider.notifier).navigateToWorkspaces();
        },
        onPressed: _toggleDropdown,
        child: const Text("Workspaces"),
      ),
    );
  }
}
