import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/leaderboard_data.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<LeaderboardEntry> _leaderboard = [];
  bool _isLoading = true;
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final leaderboard = await LeaderboardData.getLeaderboard();
      setState(() {
        _leaderboard = leaderboard;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _leaderboard = [];
        _isLoading = false;
      });
    }
  }

  List<LeaderboardEntry> get _filteredLeaderboard {
    if (_selectedCategory == 'all') {
      return _leaderboard;
    }
    return _leaderboard
        .where((entry) => entry.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7B2CBF), Color(0xFF9D4EDD), Color(0xFFC77DFF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Класация',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _loadLeaderboard(),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      tooltip: 'Обнови',
                    ),
                  ],
                ),
              ),

              // Category Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.filter_list,
                          color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedCategory,
                        dropdownColor: const Color(0xFF7B2CBF),
                        underline: const SizedBox(),
                        style: const TextStyle(color: Colors.white),
                        items: const [
                          DropdownMenuItem(value: 'all', child: Text('Всички')),
                          DropdownMenuItem(
                              value: 'geography', child: Text('География')),
                          DropdownMenuItem(
                              value: 'history', child: Text('История')),
                          DropdownMenuItem(
                              value: 'culture', child: Text('Култура')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7B2CBF)),
            ),
            SizedBox(height: 16),
            Text(
              'Зареждане на класацията...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (_filteredLeaderboard.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Няма резултати за тази категория',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Направете първия резултат!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Header Row
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF7B2CBF).withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              const Text(
                'Място',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B2CBF),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Играч',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B2CBF),
                  ),
                ),
              ),
              const Text(
                'Точки',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B2CBF),
                ),
              ),
            ],
          ),
        ),

        // Leaderboard List
        Expanded(
          child: ListView.builder(
            itemCount: _filteredLeaderboard.length,
            itemBuilder: (context, index) {
              final entry = _filteredLeaderboard[index];
              return _buildLeaderboardItem(entry, index + 1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(LeaderboardEntry entry, int position) {
    Color positionColor = Colors.grey;
    IconData positionIcon = Icons.person;

    if (position == 1) {
      positionColor = Colors.amber;
      positionIcon = Icons.emoji_events;
    } else if (position == 2) {
      positionColor = Colors.grey.shade400;
      positionIcon = Icons.emoji_events;
    } else if (position == 3) {
      positionColor = Colors.orange.shade700;
      positionIcon = Icons.emoji_events;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: position <= 3
            ? positionColor.withOpacity(0.1)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: position <= 3
            ? Border.all(color: positionColor.withOpacity(0.3), width: 2)
            : Border.all(color: Colors.grey.shade200),
        boxShadow: position <= 3
            ? [
                BoxShadow(
                  color: positionColor.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Position
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: position <= 3 ? positionColor : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: position <= 3
                  ? Icon(positionIcon, color: Colors.white, size: 20)
                  : Text(
                      '$position',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 16),

          // Player Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.playerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: position <= 3 ? positionColor : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.quizTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  _formatDate(entry.completedAt),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          // Score
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: position <= 3 ? positionColor : const Color(0xFF7B2CBF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${entry.score}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * position),
          duration: 600.ms,
        )
        .slideX();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return 'преди ${difference.inDays} дн.';
    } else if (difference.inHours > 0) {
      return 'преди ${difference.inHours} ч.';
    } else if (difference.inMinutes > 0) {
      return 'преди ${difference.inMinutes} мин.';
    } else {
      return 'току-що';
    }
  }
}
