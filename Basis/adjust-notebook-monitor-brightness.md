Check and set brightness
---

```
cat /sys/class/backlight/acpi_video0/max_brightness
cat /sys/class/backlight/acpi_video0/actual_brightness
echo 10 > /sys/class/backlight/acpi_video0/brightness
```
