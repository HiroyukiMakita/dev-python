ARG PYTHON_IMAGE
FROM ${PYTHON_IMAGE}

ARG CONTAINER_USER_NAME
ARG CONTAINER_USER_ID
ARG CONTAINER_USER_PASSWORD
ARG CONTAINER_SOURCE_ROOT
ARG POETRY_VERSION
ARG PYTHON_PORT

RUN apt-get -y update \
    # 一般ユーザーを作成、sudo グループに入れる
    && useradd -m --uid ${CONTAINER_USER_ID} --groups sudo ${CONTAINER_USER_NAME} \
    # sudo 時のパスワード入力を省略する
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    # パスワード設定
    && echo ${CONTAINER_USER_NAME}:${CONTAINER_USER_PASSWORD} | chpasswd

# 作業ディレクトリを作成・移動
RUN mkdir -p ${CONTAINER_SOURCE_ROOT}
WORKDIR ${CONTAINER_SOURCE_ROOT}

# poetry の PATH 指定
ENV POETRY_HOME /etc/poetry
ENV PATH $POETRY_HOME/bin:$PATH

# poetry インストール
ENV POETRY_VERSION=${POETRY_VERSION}
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/etc/poetry python3 -
# venv のファイルをプロジェクトディレクトリの下に置く設定
ENV POETRY_VIRTUALENVS_IN_PROJECT=true

# expose port
EXPOSE ${PYTHON_PORT}