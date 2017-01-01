from __future__ import unicode_literals

from django.conf import settings
from django.db import models

# Create your models here.
class Message(models.Model):
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True)
    content = models.TextField(default="", blank=True)

