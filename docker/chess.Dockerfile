# chess.Dockerfile

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# Install package dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        tcl \
        tcl-dev \
        tk \
        tk-dev \
        wget \
        unzip \
        fontconfig \
        libgtk2.0 \
        libcanberra-gtk-module \
        libcanberra-gtk3-module \
        chessx \
        pulseaudio
RUN apt-get clean

RUN ln -s /usr/games/chessx /usr/local/bin/chessx

# Scid vs. PC
RUN mkdir -p /tmp/scid_vs_pc && \
    cd /tmp/scid_vs_pc/ && \
    wget https://gigenet.dl.sourceforge.net/project/scidvspc/source/scid_vs_pc-4.22.tgz && \
    tar -xzf scid_vs_pc-4.22.tgz && \
    rm scid_vs_pc-4.22.tgz && \
    cd scid_vs_pc-4.22 && \
    ./configure && \
    make -j8 && \
    make install

RUN rm -rf /tmp/scid_vs_pc

COPY config/engines.dat /root/.scidvspc/config/engines.dat

# Stockfish
RUN mkdir -p /tmp/stockfish && \
    cd /tmp/stockfish/ && \
    wget https://stockfishchess.org/files/stockfish_14_linux_x64_avx2.zip && \
    unzip stockfish_14_linux_x64_avx2.zip && \
    mv /tmp/stockfish/stockfish_14_linux_x64_avx2/stockfish_14_x64_avx2 /usr/local/bin/stockfish_14_x64_avx2

RUN rm -rf /tmp/stockfish

# # Chess Database
# # Optional
# # We can add database by mounting a volume to the Docker container later.
# RUN mkdir -p /tmp/caissabase && \
#     cd /tmp/caissabase/ && \
#     wget http://caissabase.co.uk/downloads/Caissabase_2020_11_14.zip && \
#     unzip Caissabase_2020_11_14.zip

CMD ["bash", "-c" "pulseaudio --start; chessx"]

# ENTRYPOINT ["scid"]


# wget https://phoenixnap.dl.sourceforge.net/project/lucaschessr/Version_R1/LucasChessR126_LINUX.sh
