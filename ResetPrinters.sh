#!/bin/sh

# This command removes all printers. This is frequeently used as a "before" script
# prior to re-mapping printers

lpstat -p | cut -d' ' -f2 | xargs -I{} lpadmin -x {}

exit 0
