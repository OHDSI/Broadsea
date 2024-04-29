FROM odysseusinc/execution_engine:1.19.1


RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends git
apt-get clean
rm -rf /var/lib/apt/lists/*
git clone https://github.com/OHDSI/ArachneExecutionEngine.git /tmp/ArachneExecutionEngine
EOF

RUN ./tmp/ArachneExecutionEngine/src/main/dist/run_build.sh -b /dist