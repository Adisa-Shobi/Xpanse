import uuid
from django.db import models
from django.contrib.auth.models import (
    AbstractBaseUser,
    BaseUserManager,
    PermissionsMixin
)
from cloudinary.uploader import upload
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from cloudinary.models import CloudinaryField
from phonenumber_field.modelfields import PhoneNumberField


class UserManager(BaseUserManager):
    """
    Custom UserManager model that manages Accounts
    """
    use_in_migrations = True

    def create_user(self, email, password, **extra_fields):
        try:
            validate_email(email)
        except ValidationError:
            raise ValueError(f'Input a valid Email: {email} is not valid')

        user = self.model(email=self.normalize_email(email), **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self.create_user(email, password, **extra_fields)


class User(AbstractBaseUser, PermissionsMixin):
    """
    Custom user model.
    """
    id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False
    )
    first_name = models.CharField(max_length=255, blank=False)
    last_name = models.CharField(max_length=255, blank=False)
    email = models.EmailField(
        max_length=255, unique=True, validators=[validate_email])
    phone_number = PhoneNumberField(
        unique=True, null=False, blank=False
    )

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    date_joined = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now=True)

    objects = UserManager()
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['first_name', 'last_name', 'phone_number']

    def save(self, *args, **kwargs):
        try:
            self.full_clean()
        except Exception as e:
            raise e

        super(User, self).save(*args, **kwargs)

    @property
    def full_name(self):
        return f"{self.last_name} {self.first_name}"

    def __str__(self):
        """String representation of a user"""
        return f"{self.full_name} - {self.email}"

    class Meta:
        ordering = ("-date_joined",)
