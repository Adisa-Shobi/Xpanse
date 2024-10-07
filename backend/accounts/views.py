import pyotp
import base64
import hashlib
import logging
from .serializers import (
    UserSerializer,
    ResendOTPSerializer,
    VerifyAccountSerializer,
)
from rest_framework.views import APIView
from rest_framework import generics, status, serializers
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.request import Request
from rest_framework.exceptions import APIException
from rest_framework.permissions import AllowAny

from django.urls import reverse
from django.http import HttpResponse
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import make_password
from django.contrib.auth import authenticate
from django.shortcuts import get_object_or_404
from django.conf import settings


from accounts.utils import (
    send_verification_otp_email,
)


# Create your views here.
User = get_user_model()


class RegisterationView(generics.GenericAPIView):
    """
    Register a user with their email address
    """

    serializer_class = UserSerializer
    permission_classes = [AllowAny]

    def post(self, request, *args, **kwargs):
        """Create User Account using Email, sends email verification message"""

        try:
            serializer = self.serializer_class(data=request.data)

            if serializer.is_valid():
                user = serializer.save()
                user.is_active = False
                user.save()
                send_verification_otp_email(user)

                return Response(
                    data={
                        "message": "Account created, check your email to verify your account",  # noqa
                        "user": serializer.data,
                    },
                    status=status.HTTP_201_CREATED,
                )

            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response(
                data={"message": "Error", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


class ResendOTPView(generics.GenericAPIView):
    """
    Resend OTP to user email
    """

    serializer_class = ResendOTPSerializer
    permission_classes = [AllowAny]

    def get_user(self, email):
        """Get User based on email"""
        return User.objects.get(email=email)

    def send_otp(self, user):
        send_verification_otp_email(user)

    def post(self, request, *args, **kwargs):
        """Resend OTP to user email"""
        serializer = self.serializer_class(data=request.data)

        if not serializer.is_valid():
            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        user_email = serializer.validated_data["email"]

        try:
            user = self.get_user(user_email)
            self.send_otp(user)

            return Response(
                data={
                    "message": "New OTP sent, check your email to verify your account"
                },
                status=status.HTTP_200_OK,
            )
        except User.DoesNotExist:
            return Response(
                data={"message": "User not found"}, status=status.HTTP_404_NOT_FOUND
            )
        except APIException as e:
            return Response(data={"message": str(e)}, status=e.status_code)


class VerifyAccountView(generics.GenericAPIView):
    """
    Verify user account
    """

    serializer_class = VerifyAccountSerializer
    permission_classes = [AllowAny]

    def post(self, request: Request):
        """Verify User account"""
        serializer = self.serializer_class(data=request.data)
        if not serializer.is_valid():
            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        user_otp = serializer.validated_data["otp"]
        email = serializer.validated_data["email"]

        if not email or not user_otp:
            return Response(
                {"detail": "OTP receiver and OTP code are required"},
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            user = self.get_user(email)
            if self.verify_otp(user, user_otp, settings.SECRET_KEY):
                self.mark_user_verified(user)
                token_pair = self.generate_tokens(user)
                return Response(
                    {
                        "status": "success",
                        "message": "Account verified successfully",
                        "token_pair": token_pair,
                    },
                    status=status.HTTP_200_OK,
                )
            return Response(
                {"detail": "Invalid OTP"}, status=status.HTTP_400_BAD_REQUEST
            )
        except Exception as e:
            logging.exception(e)
            return Response(
                {"message": "Error", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

    def get_user(self, email):
        return User.objects.get(email=email)

    def verify_otp(self, user, user_otp, server_secret):
        # Generate the SHA-256 hash
        user_secret_hex = hashlib.sha256(
            f"{user.id}".encode()).hexdigest()

        # Convert hex to bytes, then to Base32
        user_secret_bytes = bytes.fromhex(user_secret_hex)
        user_secret_base32 = base64.b32encode(user_secret_bytes).decode('utf-8')

        # Create the TOTP instance with the Base32-encoded secret
        totp = pyotp.TOTP(user_secret_base32, interval=300, digits=4)

        # Verify the OTP
        return totp.verify(user_otp)

    def mark_user_verified(self, user):
        user.is_active = True
        user.save()

    def generate_tokens(self, user):
        """Generate tokens for a user"""
        refresh = RefreshToken.for_user(user)
        return {
            "access_token": str(refresh.access_token),
            "refresh_token": str(refresh),
        }
