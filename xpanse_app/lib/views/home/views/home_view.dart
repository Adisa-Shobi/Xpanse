import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xpanse_app/components/icom_picker.dart';
import 'package:xpanse_app/components/image_icon.dart' as img;
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/models/m_money.dart';
import 'package:xpanse_app/utils/colors.dart';
import 'package:xpanse_app/utils/format.dart';
import 'package:xpanse_app/utils/responsive.dart';
import 'package:xpanse_app/utils/snack_bar.dart';
import 'package:xpanse_app/utils/spcaing.dart';
import 'package:xpanse_app/utils/typography.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.userData.value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
              child: Column(
                children: [
                  Spacing.vertical(Spacing.l),
                  getHeading(
                    title:
                        'Good Morning, ${controller.userMetaData.value?.firstName}',
                  ),
                  Spacing.vertical(Spacing.m),
                  _buildBudgetSection(context),
                  Spacing.vertical(Spacing.l),
                  Expanded(
                    child: _buildExpenses(context),
                  ),
                ],
              ),
            ),
    );
  }

  _buildBudgetSection(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // Wrap the Row with Expanded
                child: Row(
                  children: [
                    const img.CustomIcon(
                      imagePath: "assets/images/target.png",
                      size: 40,
                    ),
                    Spacing.horizontal(Spacing.s),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Targeted Budget',
                            style: AppTypography.bodyLarge,
                          ),
                          Spacing.vertical(Spacing.xs),
                          Text(
                            'Rwf ${formatWithCommas(controller.userData.value!.budget)}',
                            style: AppTypography.h1.copyWith(
                              height: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Remove the Expanded here
              TextButton(
                onPressed: () {
                  _showBudgetBottomSheet(context);
                },
                child: const Text(
                  'Set',
                  softWrap: false,
                ),
              ),
            ],
          ),
          Spacing.vertical(Spacing.m),
          Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: Responsive.widthPercent(context, 100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'This Motnh\'s Budget',
                      style: AppTypography.bodyLarge.copyWith(
                        // color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Rwf ${formatWithCommas(controller.monthlyExenditure.value)} of Rwf ${formatWithCommas(controller.userData.value!.budget)}',
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Spacing.vertical(Spacing.m),
              LinearPercentIndicator(
                padding: const EdgeInsets.all(0),
                lineHeight: 20.0,
                percent: controller.monthlyExenditure.value /
                    controller.userData.value!.budget,
                progressColor: AppColors.primary,
                barRadius: const Radius.circular(Spacing.s),
                backgroundColor: AppColors.primary.withOpacity(0.2),
                // width: Responsive.widthPercent(context, 100),
              )
            ],
          )
        ],
      ),
    );
  }

  _showBudgetBottomSheet(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _budgetController = TextEditingController();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(Spacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Set Budget',
              style: AppTypography.h3,
            ),
            Spacing.vertical(Spacing.s),
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Set Budget',
                  labelStyle: AppTypography.caption,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.1),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                style: AppTypography.bodyMedium,
                controller: _budgetController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter a value';
                  }
                  if (int.tryParse(val) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
            Spacing.vertical(Spacing.s),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final res = await controller
                        .updateUserData(controller.userData.value!.copyWith(
                      budget: int.parse(_budgetController.text),
                    ));
                    if (res != null) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  'Save',
                  style: AppTypography.button.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.m),
          topRight: Radius.circular(Spacing.m),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildExpenses(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Expenses',
            textAlign: TextAlign.start,
            style: AppTypography.h3,
          ),
          Spacing.vertical(Spacing.s),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ExpenseItem(
                  transaction: controller.transactions[index],
                );
              },
              itemCount: controller.transactions.length,
            ),
          ),
        ],
      ),
    );
  }
}

getHeading({title}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFE8F5E9), // Light green background
        ),
        child: ClipOval(
          child: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY2r1g-oKe7WxMwyuhsS5reYmvZ8l5fABcsg&s',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to icon if image fails to load
              return Center(
                child: Icon(
                  Icons.person,
                  color: Colors.grey[600],
                  size: 24,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              // Show loading indicator while image loads
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
      Spacing.horizontal(Spacing.l),
      Text(
        title,
        style: AppTypography.h3,
      ),
    ],
  );
}

class ExpenseItem extends StatelessWidget {
  final MoMoTransaction transaction;
  const ExpenseItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (transaction.type == TransactionType.SENT) {
          _showChangeCategory(
            context,
            transaction,
          );
        } else {
          negativeMessage(
            message: 'You can only change category for expenses',
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Avatar container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: transaction.type == TransactionType.SENT
                      ? Colors.red.withOpacity(0.2)
                      : AppColors.primary.withOpacity(0.2),
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      transaction.type == TransactionType.RECEIVED
                          ? 'assets/images/exp-arrow.png'
                          : 'assets/images/exp-arrow-down.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Spacing.horizontal(Spacing.s),

              // Name and timestamp
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.type == TransactionType.RECEIVED
                          ? transaction.senderName ?? ''
                          : transaction.recipientName ?? '',
                      style: AppTypography.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      getTimeAgo(transaction.timestamp),
                      style: AppTypography.caption,
                    )
                  ],
                ),
              ),
              Spacing.horizontal(Spacing.s),
              // Amount
              Text(
                'Rwf ${formatWithCommas(transaction.amount)}',
                style: AppTypography.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangeCategory(BuildContext context, MoMoTransaction transaction) {
    final selectedCategory = transaction.category.obs;
    final HomeController controller = Get.find();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(Spacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Category',
              style: AppTypography.h3,
            ),
            Spacing.vertical(Spacing.s),
            Text(
              'Select a category for this transaction',
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.grey,
              ),
            ),
            Spacing.vertical(Spacing.m),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: controller.categories.map((category) {
                        final isSelected =
                            selectedCategory.value == category.name;

                        return InkWell(
                          onTap: () {
                            selectedCategory.value = category.name;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(Spacing.s),
                            margin: const EdgeInsets.only(bottom: Spacing.xs),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.black.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  icons[category.icon]?.icon,
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.grey,
                                ),
                                Spacing.horizontal(Spacing.s),
                                Text(
                                  category.name,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )),
              ),
            ),
            Spacing.vertical(Spacing.m),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (selectedCategory.value != null) {
                    await controller.updateTransaction(
                      transaction.copyWith(
                        category: selectedCategory.value,
                      ),
                    );
                    positiveMessage(
                      message: 'Category updated successfully',
                    );
                    Navigator.pop(context);
                  } else {
                    negativeMessage(
                      message: 'Please select a category',
                    );
                  }
                },
                // onPressed: selectedCategory.value != null
                //     ? () async {
                //         try {
                //           await controller.updateTransactionCategory(
                //             transaction,
                //             selectedCategory.value!,
                //           );
                //           Get.back();
                //           positiveMessage(
                //               message: 'Category updated successfully');
                //         } catch (e) {
                //           negativeMessage(
                //               message: 'Failed to update category: $e');
                //         }
                //       }
                //     : null,
                child: Text(
                  'Save Changes',
                  style: AppTypography.button.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.m),
          topRight: Radius.circular(Spacing.m),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }
}
