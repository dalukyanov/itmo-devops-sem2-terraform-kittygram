from rest_framework import routers

from django.contrib import admin
from django.urls import include, path
from django.http import JsonResponse

from cats.views import AchievementViewSet, CatViewSet


router = routers.DefaultRouter()
router.register(r'cats', CatViewSet)
router.register(r'achievements', AchievementViewSet)


def home(request):
    """Простая страница приветствия для корневого пути"""
    return JsonResponse({
        'message': 'Welcome to Kittygram API!',
        'endpoints': {
            'api': '/api/',
            'admin': '/admin/',
            'api_cats': '/api/cats/',
            'api_users': '/api/users/',
        },
        'documentation': 'https://github.com/dalukyanov/itmo-devops-sem2-terraform-kittygram'
    })


urlpatterns = [
    path('', home, name='home'),  # Корневой путь возвращает JSON
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('api/', include('djoser.urls')),
    path('api/', include('djoser.urls.authtoken')),
]