from django.urls import path
from accounts import views


urlpatterns = [
    path(
        "register/",
        views.RegisterationView.as_view(),
        name="Register"
    ),
    path(
       "resend-otp",
        views.ResendOTPView.as_view(),
        name="resend-otp"
    ),
    path(
        "verify",
        views.VerifyAccountView.as_view(),
        name="verify-account"
    )
]
