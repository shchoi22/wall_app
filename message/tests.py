import json

from django.test import TestCase, Client
from django.core import mail

class AuthenticatedSessionApiTestCase(TestCase):
    def setUp(self):
        self.c = Client()
        self.c.post("/api/v1/users/signup/",
            data=json.dumps({ "username": "test@test.com", "password": "testing" }), 
            content_type='application/json')
        
        self.c.login(username="test@test.com", password="testing")
    
    def test_welcome_email(self):
        self.assertEqual(len(mail.outbox), 1)
        email = mail.outbox.pop()

        self.assertEqual(email.subject, 'Welcome to Wall App')
        self.assertEqual(email.to[0], 'test@test.com')

    def test_create_message(self):
        response = self.c.post('/api/v1/messages/',
            data=json.dumps({"content": "testing"}),
            content_type='application/json')
        self.assertEqual(response.status_code, 201)
