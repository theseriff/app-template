"""Main entry point for the application."""

import asyncio
import logging

logger = logging.getLogger(__name__)


async def main() -> None:
    """Run the main application logic."""
    logger.info("hello world")


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.run(main())
