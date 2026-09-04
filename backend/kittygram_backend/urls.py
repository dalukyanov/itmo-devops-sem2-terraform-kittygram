from rest_framework import routers

from django.contrib import admin
from django.urls import include, path
from django.shortcuts import redirect

from cats.views import AchievementViewSet, CatViewSet


router = routers.DefaultRouter()
router.register(r'cats', CatViewSet)
router.register(r'achievements', AchievementViewSet)

urlpatterns = [
    # Редирект с корневого пути на API
    path('', lambda request: redirect('/api/')),
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('api/', include('djoser.urls')),  # Работа с пользователями
    path('api/', include('djoser.urls.authtoken')),  # Работа с токенами
]