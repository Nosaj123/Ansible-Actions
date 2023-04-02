FROM alpine:3.17.3

COPY files/ansible.cfg /tmp/ansible.cfg

ARG PIP_ROOT_USER_ACTION=ignore

ENV PYTHONUNBUFFERED=1

RUN apk add --update --no-cache \
        bash \
        ca-certificates \
        curl \
        git \
        gcc \
        libffi-dev \
        musl-dev \
        openssh-client \
        openssl \
        py3-boto3 \
        py3-botocore \
        py3-jmespath \
        py3-pip \
        py3-psycopg2 \
        py3-setuptools \
        py3-wheel \
        python3 \
        python3-dev \
        rsync \
        sshpass \
        sudo \
        tar \
    && pip3 install --no-cache --upgrade \
        pip \
        setuptools \
        ansible-core \
        cryptography \
        docker \
        mitogen \
        ndg-httpsclient \
        passlib[bcrypt] \
        pyasn1 \
        psycopg2 \
        pyOpenSSL \
        pywinrm \
    && mkdir -p \
        /root/.ssh \
        /etc/ansible/roles \
        /usr/share/ansible/roles \
    && touch /tmp/id_rsa \
    && install -o root -g root -m 600 /tmp/id_rsa /root/.ssh/id_rsa \
    && install -m 644 /tmp/ansible.cfg /etc/ansible/ansible.cfg \
    && rm -rf /var/cache/apk/* /root/.cache /root/.cargo

CMD [ "ansible", "--version" ]