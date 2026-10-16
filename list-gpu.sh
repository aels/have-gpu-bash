gpu=0
for d in /sys/bus/pci/devices/*; do
  [ -r "$d/class" ] || continue
  case "$(cat "$d/class")" in
    0x03*)  # класс 0x0300 VGA, 0x0302 3D-контроллер (датацентровые GPU), 0x0380 display
      gpu=1
      v=$(cat "$d/vendor")
      case "$v" in
        0x10de) vn=NVIDIA;; 0x1002) vn=AMD;; 0x8086) vn=Intel;; *) vn="vendor $v";;
      esac
      echo "[hw] PCI GPU: $(basename $d)  $vn  (device $(cat $d/device))"
      command -v lspci >/dev/null && lspci -s "$(basename $d)" -nn 2>/dev/null
      ;;
  esac
done
command -v nvidia-smi >/dev/null && nvidia-smi -L 2>/dev/null
command -v rocm-smi  >/dev/null && rocm-smi --showproductname 2>/dev/null
ls /dev/nvidia* /dev/kfd /dev/dri/render* /dev/dxg /dev/mali* /dev/nvhost* 2>/dev/null
[ "$gpu" -eq 0 ] && echo "NO GPU detected"
