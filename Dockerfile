FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS builder
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy
ENV UV_PYTHON_DOWNLOADS=0

WORKDIR /app

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev

COPY --chown=1000:1000 pyproject.toml uv.lock ./
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-install-project --no-dev

COPY --chown=1000:1000 ./README.md ./
COPY --chown=1000:1000 ./src ./src
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

FROM python:3.13-slim

RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -d /app -s /bin/bash appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

WORKDIR /app

USER appuser

COPY --from=builder --chown=1000:1000 /app /app

ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

CMD ["python", "-m", "app.main"]
