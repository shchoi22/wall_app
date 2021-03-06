from django.conf.urls import include, url

from tastypie.api import Api
from message.api import MessageResource, UserResource

v1_api = Api(api_name='v1')
v1_api.register(UserResource())
v1_api.register(MessageResource())

urlpatterns = [
    url(r'^api/', include(v1_api.urls)),
]
