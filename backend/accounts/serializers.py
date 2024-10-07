from django.contrib.auth import get_user_model
from rest_framework import serializers, status


class UserSerializer(serializers.ModelSerializer):
    """
    Serializer for the user object
    """
    class Meta:
        model = get_user_model()
        exclude = (
            'groups',
            'is_staff',
            'is_active',
            'last_login',
            'is_superuser',
            'date_modified',
            'user_permissions',
        )
        required_fields = ['email', 'password', 'first_name', 'last_name']
        extra_kwargs = {'password': {'write_only': True, 'min_length': 5}}

    def create(self, validated_data):
        """
        Create a user with encrypted password and returns the user instance
        """
        return get_user_model().objects.create_user(
            **validated_data, is_active=False
        )

    def update(self, instance, validated_data):
        """
        Update a user, setting the password correctly and return it
        """
        password = validated_data.pop('password', None)
        user = super().update(instance, validated_data)

        if password:
            user.set_password(password)
            user.save()

        return user


class ResendOTPSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)


class VerifyAccountSerializer(serializers.Serializer):
    otp = serializers.CharField(min_length=4, max_length=4, required=True)
    email = serializers.EmailField(required=True)
