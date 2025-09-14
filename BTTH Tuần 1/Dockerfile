FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    tightvncserver \
    sudo \
    xterm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

    RUN useradd -m -s /bin/bash ubuntu && \
    echo 'ubuntu:ubuntu123' | chpasswd && \
    usermod -aG sudo ubuntu

RUN mkdir /var/run/sshd && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config


EXPOSE 22 5901

RUN echo '#!/bin/bash\n\
# Khởi động SSH daemon\n\
service ssh start\n\
\n\
# Chờ một chút để SSH service khởi động hoàn toàn\n\
sleep 2\n\
\n\
# Tạo cấu hình VNC cho user ubuntu (với twm làm window manager cơ bản)\n\
su - ubuntu -c "mkdir -p ~/.vnc \
  && echo twm > ~/.vnc/xstartup \
  && chmod +x ~/.vnc/xstartup \
  && echo vncpass123 | vncpasswd -f > ~/.vnc/passwd \
  && chmod 600 ~/.vnc/passwd \
  && vncserver :1 -geometry 1024x768"\n\

echo "========================================"\n\
echo "Container đã khởi động thành công!"\n\
echo "SSH: ssh ubuntu@localhost -p 2222"\n\
echo "Password: ubuntu123"\n\
echo "VNC: localhost:5901"\n\
echo "VNC Password: vncpass123"\n\
echo "========================================"\n\
\n\
# Giữ container chạy\n\
tail -f /dev/null' > /start.sh && chmod +x /start.sh

COPY setup-de.sh /home/ubuntu/setup-de.sh
RUN chmod +x /home/ubuntu/setup-de.sh && \
    chown ubuntu:ubuntu /home/ubuntu/setup-de.sh

CMD ["/start.sh"]