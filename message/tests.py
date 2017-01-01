import logging
import json

from django.test import TestCase, Client, override_settings
from django.core import mail
from django.conf import settings
from django.core.urlresolvers import reverse

from tastypie.exceptions import Unauthorized

class AuthenticatedSessionApiTestCase(TestCase):
    def setUp(self):
        self.c = Client()
        self.c.post("/api/v1/users/signup/",
            data=json.dumps({ "username": "test@test.com", "password": "testing" }), 
            content_type='application/json')
        
        self.c.login(username="test@test.com", password="testing")

    def test_get_user_me(self):
        response = self.c.post('/api/v1/messages/',
            data=json.dumps({"content": "testing"}),
            content_type='application/json')
        self.assertEqual(response.status_code, 201)
