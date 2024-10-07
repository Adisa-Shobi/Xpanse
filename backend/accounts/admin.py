from django.contrib import admin
from accounts import models
from django.utils.translation import gettext as translate_text
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin


@admin.register(models.User)
class UserAdmin(BaseUserAdmin):
    """
    The user model for admin
    """
    ordering = ['id']
    list_display = [
        'email', 'first_name', 'last_name',
        'phone_number', 'is_active', 'is_staff',
    ]
    search_fields = ['email', 'first_name', 'last_name', 'phone_number']
    readonly_fields = ['last_login', 'date_joined', 'date_modified']

    fieldsets = (
        (
            None,
            {
                'fields': (
                    'email',
                    'password',
                )
            }
        ),
        (
            translate_text('Personal Info'),
            {
                'fields': (
                    'first_name',
                    'last_name',
                    'phone_number'
                )
            }
        ),
        (
            translate_text('Permissions'),
            {
                'fields': (
                    'is_active',
                    'is_staff',
                    'is_superuser',
                )
            }
        ),
        (
            translate_text('Important dates'),
            {
                'fields': (
                    'last_login',
                    'date_joined',
                    'date_modified',
                )
            }
        )
    )

    add_fieldsets = (
        (
            None,
            {
                'classes': ('wide',),
                'fields': (
                    'email',
                    'password1',
                    'password2',
                    'first_name',
                    'last_name',
                    'phone_number'
                    'is_staff',
                    'is_active',
                    'is_superuser',
                )
            }
        ),
    )
