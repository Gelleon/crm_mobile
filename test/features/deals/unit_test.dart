import 'package:crm_mobile/core/services/auth_service.dart';
import 'package:crm_mobile/features/deals/domain/entities/deal.dart';
import 'package:crm_mobile/features/deals/domain/entities/deal_status.dart';
import 'package:crm_mobile/features/deals/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Deal Entity', () {
    test(
      'isInTurnover returns true for paid/completed deals with payment date',
      () {
        final deal = Deal(
          id: '1',
          clientId: 'c1',
          products: [],
          status: DealStatus.paid,
          createdAt: DateTime.now(),
          paymentDate: DateTime.now(),
          totalAmount: 100,
        );
        expect(deal.isInTurnover, true);
      },
    );

    test('isInTurnover returns false for unpaid deals', () {
      final deal = Deal(
        id: '1',
        clientId: 'c1',
        products: [],
        status: DealStatus.inProgress,
        createdAt: DateTime.now(),
        totalAmount: 100,
      );
      expect(deal.isInTurnover, false);
    });
  });

  group('AuthService', () {
    final authService = AuthService();

    test('canEditDeal returns true for new deal (null author)', () async {
      expect(await authService.canEditDeal(null), true);
    });

    test('canEditDeal returns true for author', () async {
      expect(await authService.canEditDeal('user_1'), true);
    });

    test('canDeleteDeal returns true for new deal (null author)', () async {
      expect(await authService.canDeleteDeal(null), true);
    });

    test('canDeleteDeal returns true for author', () async {
      expect(await authService.canDeleteDeal('user_1'), true);
    });

    // Note: In current mock implementation isAdmin is always true,
    // so it always returns true.
    // If we were to test non-admin logic, we would need to mock properties.
  });
}
