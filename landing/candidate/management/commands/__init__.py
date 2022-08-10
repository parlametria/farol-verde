from abc import ABC, abstractmethod

from django.core.management.base import OutputWrapper
from django.core.management.color import Style


class ApiFetcher(ABC):
    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style

    @abstractmethod
    def start_fetch(self):
        pass
