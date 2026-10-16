No root required — class/vendor/device under /sys are readable by any user.
Nothing needs to be installed — for/case/cat/ls are available everywhere; lspci, nvidia-smi, and rocm-smi are used only if they’re already present.
The script is POSIX-compatible, so if bash ever happens to be missing (it’s present on all the distros listed), replace 'bash -s' with 'sh -s' and it will still work.
The only real caveat is containers. This is especially relevant on CloudLinux (LVE/OpenVZ/Virtuozzo on hosting platforms): inside a container, /sys/bus/pci is often empty and the host’s hardware isn’t visible. That’s exactly why the script includes the fallback checks for /dev/nvidia* and /dev/kfd — if a GPU is passed through into the container, the device nodes will show up; if it isn’t passed through, it simply cannot be detected from inside the container.


Usage:
```
curl -sSLk https://cdn.jsdelivr.net/gh/aels/have-gpu-bash/list-gpu.sh | sh
```
