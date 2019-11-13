1. 需要在Linux桌面中同时录制视频和音频(X11)  
  - 安装ffmpeg/libav 和 pulseaudio-utils
    ```
    #dnf install  -y ffmpeg   pulseaudio-utils
    ```
  - 获取speaker占用的设备(播放器或者网页播放的声音)
    ```
    # pactl list sources| grep alsa_output.pci-[0-9_.a-z]*.analog-stereo.monitor
                Name: alsa_output.pci-0000_1f_00.3.analog-stereo.monitor
    ```
    - alsa_output.pci-0000_1f_00.3.analog-stereo.monitor:表示从音响或耳机中的声音（即播放视频或音频时听到的声音）,monitor表示监听内部声音
    有时需要同时录制麦克风的声音,获取麦克风设备，不含monitor的音频输入设备：    
    - alsa_output.pci-0000_1f_00.3.analog-stereo：表示麦克风设备
  - 安装pavucontrol，选择正确的输入设备，内部monitor（默认内部音频，模拟立体声） 和麦克风(也是内部音频，模拟立体声，但是端口要选择已经插入可工作的设备)

  - 录制
    ```
    ffmpeg  -v 0 -f x11grab -s 1600x900 -i :0.0  -f pulse -i alsa_output.pci-0000_1f_00.3.analog-stereo   -f pulse -i alsa_output.pci-0000_1f_00.3.analog-stereo.monitor   -map 0:0 -map 1:0 -map 2:0　 1.mkv
    ```
    - -v 0 不打印屏幕日志
    - -f 强制覆盖文件
    - -f x11grab 表示录制x11桌面
    - -s 分辨率
    - -f pulse -i  alsa_input.pci-0000_00_1b.0.analog-stereo 录制麦克风的声音
    - -f pulse -i alsa_output.pci-0000_1f_00.3.analog-stereo.monitor 录制播放器发出的声音
    - -map 0:0 -map 1:0 -map 2:0 : 多个stream需要使用map参数（三个及以上），第一个是0:0，第二个是1:0, 第三个是3:0, 录制时，将麦克风的音轨放前面，播放声音speaker的音轨放后面。


    或者只是录制桌面和播放器的声音
    ```
    ffmpeg  -v 0 -y   -f x11grab -s 3840x2160  -i :0.0  -f pulse -i alsa_output.pci-0000_1f_00.3.analog-stereo.monitor   -map 0:0 -map 1:0  recording-$(date +%Y-%m-%d).mkv
    ```