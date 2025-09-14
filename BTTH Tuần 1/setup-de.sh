#!/bin/bash

echo "================================================"
echo "Script hỗ trợ cài đặt Desktop Environment và VNC"
echo "================================================"

# Function để cài đặt Xfce4
install_xfce4() {
    echo "Đang cài đặt Xfce4..."
    sudo apt update
    sudo apt install -y xfce4 xfce4-goodies
    
    # Cấu hình VNC startup cho Xfce4
    mkdir -p ~/.vnc
    echo "#!/bin/bash" > ~/.vnc/xstartup
    echo "xrdb \$HOME/.Xresources" >> ~/.vnc/xstartup
    echo "startxfce4 &" >> ~/.vnc/xstartup
    chmod +x ~/.vnc/xstartup
    
    echo "Xfce4 đã được cài đặt thành công!"
}

# Function để khởi động VNC server
start_vnc() {
    echo "Đang khởi động VNC server..."
    vncserver :1 -geometry 1024x768 -depth 24
    echo "VNC server đã khởi động!"
    echo "Kết nối qua: localhost:5901"
}

# Function để stop VNC server
stop_vnc() {
    echo "Đang dừng VNC server..."
    vncserver -kill :1
    echo "VNC server đã dừng!"
}

# Menu chính
while true; do
    echo ""
    echo "Chọn desktop environment để cài đặt:"
    echo "1) Xfce4 (nhẹ, khuyến nghị)"
    echo "2) Khởi động VNC server"
    echo "3) Dừng VNC server"
    echo "4) Thoát"
    echo ""
    read -p "Nhập lựa chọn (1-4): " choice
    
    case $choice in
        1)
            install_xfce4
            setup_vnc
            ;;
        2)
            start_vnc
            ;;
        3)
            stop_vnc
            ;;
        4)
            echo "Thoát script."
            exit 0
            ;;
        *)
            echo "Lựa chọn không hợp lệ!"
            ;;
    esac
done
