import json

from django.conf.urls import url
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

from tastypie import fields
from tastypie.resources import ModelResource
from tastypie.authentication import SessionAuthentication

from message.models import Message
from message.authorization import UserAuthorization, MessageAuthorization

from tastypie.authorization import Authorization

class UserResource(ModelResource):
    class Meta:
        queryset = User.objects.all()
        resource_name = 'users'
        excludes = ['email', 'password', 'is_active', 'is_staff', 'is_superuser']
        allowed_methods = ['get', 'post']
        authorization = UserAuthorization()
        authentication = SessionAuthentication()

    def prepend_urls(self):
         return [
            url(r"^(?P<resource_name>%s)/me/?$" % self._meta.resource_name, self.wrap_view('me')),
            url(r"^(?P<resource_name>%s)/signup/?$" % self._meta.resource_name, self.wrap_view('signup')),
            url(r"^(?P<resource_name>%s)/login/?$" % self._meta.resource_name, self.wrap_view('login')),
        ]

    def me(self, request, *args, **kwargs):
        self.is_authenticated(request)
        kwargs['pk'] = request.user.id
        return self.dispatch_detail(request, **kwargs)

    def login(self, request, *args, **kwargs):
        self.method_check(request, allowed=['post'])
        self.throttle_check(request)

        data = json.loads(request.body)

        username = data.get('username')
        password = data.get('password')

        user = authenticate(username=username, password=password)

        if user:
            login(request, user)
            return self.get_detail(request, pk=user.pk)
        else:
            return self.error_response(request, {'message': 'Incorrect login info'})

    def signup(self, request, *args, **kwargs):
        self.method_check(request, allowed=['post'])
        self.throttle_check(request)
        data = json.loads(request.body)

        username = data.get('username')
        password = data.get('password')

        form = UserCreationForm({
            "username": username,
            "password1": password,
            "password2": password,
        })

        if form.is_valid():
            form.save()
            user = authenticate(username=username, password=password)
            return self.create_response(request, 200)
        else:
            return self.error_response(request, form.errors)

class MessageResource(ModelResource):

    class Meta:
        queryset = Message.objects.all()
        resource_name = 'messages'
        allowed_methods = ['get', 'post']
        authorization = MessageAuthorization()


