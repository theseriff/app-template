"""Core scheduling components for the jobify framework.

This module provides the basic classes for job scheduling and management.
It exposes the main scheduler interface and job planning components that
form the basis of the jobify asynchronous job scheduling system.
"""

from importlib.metadata import version as get_version

__version__ = get_version("app")
