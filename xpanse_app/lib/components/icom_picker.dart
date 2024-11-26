import 'package:flutter/material.dart';
import 'package:xpanse_app/utils/colors.dart';
import 'package:xpanse_app/utils/typography.dart';

class CustomIcon {
  final String name;
  final IconData icon;

  CustomIcon({required this.name, required this.icon});
}

final Map<String, CustomIcon> icons = {
  'Shopping Cart': CustomIcon(name: 'Shopping Cart', icon: Icons.shopping_cart),
  'Restaurant': CustomIcon(name: 'Restaurant', icon: Icons.restaurant),
  'Car': CustomIcon(name: 'Car', icon: Icons.directions_car),
  'House': CustomIcon(name: 'House', icon: Icons.house),
  'Entertainment': CustomIcon(name: 'Entertainment', icon: Icons.movie),
  'Gift': CustomIcon(name: 'Gift', icon: Icons.card_giftcard),
  'Health': CustomIcon(name: 'Health', icon: Icons.health_and_safety),
  'Education': CustomIcon(name: 'Education', icon: Icons.school),
  'Travel': CustomIcon(name: 'Travel', icon: Icons.flight),
  'Bills': CustomIcon(name: 'Bills', icon: Icons.receipt),
  'Sports': CustomIcon(name: 'Sports', icon: Icons.sports_basketball),
  'Clothing': CustomIcon(name: 'Clothing', icon: Icons.checkroom),
  'Technology': CustomIcon(name: 'Technology', icon: Icons.computer),
  'Pets': CustomIcon(name: 'Pets', icon: Icons.pets),
  'Beauty': CustomIcon(name: 'Beauty', icon: Icons.face),
};

class IconPickerFormField extends FormField<CustomIcon> {
  IconPickerFormField({
    Key? key,
    FormFieldSetter<CustomIcon>? onSaved,
    FormFieldValidator<CustomIcon>? validator,
    CustomIcon? initialValue,
    bool autovalidate = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<CustomIcon> state) {
            return IconPicker(
              selectedIcon: state.value,
              onIconSelected: (CustomIcon icon) {
                state.didChange(icon);
              },
              hasError: state.hasError,
              errorText: state.errorText,
            );
          },
        );
}

class IconPicker extends StatefulWidget {
  final CustomIcon? selectedIcon;
  final Function(CustomIcon) onIconSelected;
  final bool hasError;
  final String? errorText;

  const IconPicker({
    Key? key,
    this.selectedIcon,
    required this.onIconSelected,
    this.hasError = false,
    this.errorText,
  }) : super(key: key);

  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Select an Icon',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    final iconData = icons.values.toList()[index];
                    final isSelected = widget.selectedIcon == iconData;

                    return InkWell(
                      onTap: () {
                        widget.onIconSelected(iconData);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.1)
                              : null,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconData.icon,
                              color: isSelected ? AppColors.primary : null,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              iconData.name,
                              style: AppTypography.caption.copyWith(
                                fontSize: 10,
                                color: isSelected ? AppColors.primary : null,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _showIconPicker,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.hasError ? Colors.red : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (widget.selectedIcon != null) ...[
                  Icon(widget.selectedIcon!.icon),
                  const SizedBox(width: 8),
                  Text(
                    widget.selectedIcon!.name,
                    style: AppTypography.bodyMedium,
                  ),
                ] else
                  Text(
                    'Select an icon',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (widget.hasError && widget.errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}

// Example Usage:
/*
class CategoryForm extends StatefulWidget {
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  CustomIcon? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          IconPickerFormField(
            onSaved: (CustomIcon? value) {
              _selectedIcon = value;
              // When saving to Firestore, you might want to save it like:
              // category.icon = value?.icon.codePoint.toString();
            },
            validator: (CustomIcon? value) {
              if (value == null) {
                return 'Please select an icon';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Use _selectedIcon here
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
*/