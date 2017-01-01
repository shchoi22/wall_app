from tastypie.authorization import Authorization
from tastypie.exceptions import Unauthorized

class BaseAuthorization(Authorization):
    def read_list(self, object_list, bundle):
        return object_list
    def read_detail(self, object_list, bundle):
        return Unauthorized()
    def create_list(self, object_list, bundle):
        raise Unauthorized()
    def update_list(self, object_list, bundle):
        raise Unauthorized()
    def update_detail(self, object_list, bundle):
        return Unauthorized()
    def delete_list(self, object_list, bundle):
        raise Unauthorized()
    def delete_detail(self, object_list, bundle):
        return Unauthorized()

class UserAuthorization(BaseAuthorization):
    def read_detail(self, object_list, bundle):
        return bundle.obj.pk == bundle.request.user.pk

class MessageAuthorization(BaseAuthorization):
    def read_list(self, object_list, bundle):
        return object_list
    def create_detail(self, object_list, bundle):
        return bundle.request.user.is_authenticated()
