import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/screens/create_card_screen.dart';
import 'package:pp191225/presentation/vocab/screens/deck_detail_screen.dart';
import 'package:pp191225/presentation/vocab/screens/study_session_screen.dart';

final vocabRoutes = <GoRoute>[
  GoRoute(
    path: RouteConstants.deckDetail,
    builder: (context, state) => DeckDetailScreen(
      deck: state.extra as Deck,
    ),
  ),
  GoRoute(
    path: RouteConstants.cardForm,
    builder: (context, state) => CreateCardScreen(
      deck: state.extra as Deck,
    ),
  ),
  GoRoute(
    path: RouteConstants.studySession,
    builder: (context, state) => StudySessionScreen(
      deckId: state.extra as String?,
    ),
  ),
];
