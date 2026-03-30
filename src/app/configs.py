"""Configuration management module."""

from typing import NamedTuple, Self


class Configs(NamedTuple):
    """Application configuration container."""

    @classmethod
    def from_env(cls) -> Self:
        """Load configuration from environment variables."""
        return cls()
