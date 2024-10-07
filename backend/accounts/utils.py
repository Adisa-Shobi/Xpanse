import time
import pyotp
import base64
import hashlib
from django.conf import settings
from django.core.cache import cache
from rest_framework.response import Response
from django.template.loader import render_to_string
from django.core import mail
from django.utils.html import strip_tags


MAX_OTP_ATTEMPTS = 5
LOCK_EXPIRATION = 600
MIN_WAIT_TIME = 60


def generate_otp(user, otp_length=4):
    current_time = time.time()
    last_request_time_key = f"last_request_time_{user.email}"
    last_request_time = cache.get(last_request_time_key, 0)
    if current_time - last_request_time < MIN_WAIT_TIME:
        wait_time = int(MIN_WAIT_TIME - (current_time - last_request_time))
        return Response(
            {"detail": f"Wait {wait_time} seconds before requesting new OTP"},
            status=429
        )

    otp_attempts_key = f"otp_attempts_{user.email}"
    otp_attempts = cache.get(otp_attempts_key, [])

    otp_attempts = [
        timestamp for timestamp in otp_attempts if current_time - timestamp < LOCK_EXPIRATION
    ]

    if len(otp_attempts) >= MAX_OTP_ATTEMPTS:
        return Response(
            {"detail": "Exceeded maximum OTP attempts. Please try again later."},
            status=429
        )

    # Original secret generation
    user_secret_hex = hashlib.sha256(
        f"{user.id}".encode()).hexdigest()

    # Convert hex to bytes, then to Base32
    user_secret_bytes = bytes.fromhex(user_secret_hex)
    user_secret_base32 = base64.b32encode(user_secret_bytes).decode('utf-8')

    # Generate TOTP with Base32-encoded secret
    totp = pyotp.TOTP(user_secret_base32, interval=300, digits=otp_length)
    otp = totp.now()

    # Increment the OTP attempts with the current timestamp
    otp_attempts.append(current_time)
    cache.set(otp_attempts_key, otp_attempts, timeout=LOCK_EXPIRATION)

    # Update the last request time
    cache.set(last_request_time_key, current_time, timeout=LOCK_EXPIRATION)

    return otp


# Send OTP via Email
def send_verification_otp_email(user):
    """Send a user account verification email"""
    otp = str(generate_otp(user))
    subject = f"{otp} is Your XPanse verification code"

    context = {
        'otp': otp,
        'user': user
    }

    html_content = render_to_string('emails/verification_email.html', context)
    plain_message = strip_tags(html_content)

    mail.send_mail(
        subject=subject,
        message=plain_message,
        from_email=settings.EMAIL_HOST_USER,
        recipient_list=[user.email],
        html_message=html_content
    )
