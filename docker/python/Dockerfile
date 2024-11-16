ARG PYTHON_IMAGE
FROM ${PYTHON_IMAGE}

ARG CONTAINER_USER_NAME
ARG CONTAINER_USER_ID
ARG CONTAINER_SOURCE_ROOT
ARG PYTHON_PORT

RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git vim sudo curl lsof unzip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN --mount=type=secret,id=CONTAINER_USER_PASSWORD \
    # 一般ユーザーを作成、sudo グループに入れる
    useradd -m --uid ${CONTAINER_USER_ID} --groups sudo ${CONTAINER_USER_NAME} \
    # sudo 時のパスワード入力を省略する
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    # パスワード設定
    && echo ${CONTAINER_USER_NAME}:$(cat /run/secrets/CONTAINER_USER_PASSWORD) | chpasswd

# 作業ディレクトリを作成
RUN mkdir -p ${CONTAINER_SOURCE_ROOT} \
    && chown -R ${CONTAINER_USER_NAME}:${CONTAINER_USER_NAME} ${CONTAINER_SOURCE_ROOT}

USER ${CONTAINER_USER_NAME}

# Git の設定
RUN --mount=type=secret,id=CONTAINER_GIT_USER \
    --mount=type=secret,id=CONTAINER_GIT_EMAIL \
    git config --global --add safe.directory ${CONTAINER_SOURCE_ROOT} \
    && git config --global user.name $(sudo cat /run/secrets/CONTAINER_GIT_USER) \
    && git config --global user.email $(sudo cat /run/secrets/CONTAINER_GIT_EMAIL)

WORKDIR ${CONTAINER_SOURCE_ROOT}

#[uv](https://docs.astral.sh/uv/) のインストール
# https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh;

ENV VIRTUAL_ENV ${CONTAINER_SOURCE_ROOT}/.venv
ENV BASH_ENV ~/.bashrc
ENV PATH="/home/${CONTAINER_USER_NAME}/.local/bin/:$PATH"

# expose port
EXPOSE ${PYTHON_PORT}