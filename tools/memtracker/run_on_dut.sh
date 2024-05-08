#!/bin/bash
# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -euo pipefail

SCRIPT_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

host="$1"
shift

echo "RUNNING ON DEVICE ${host}"

# Disable warning about $* expanding on the client side; this is what we want.
# shellcheck disable=SC2029
ssh "${host}" \
    "rm -f /home/chronos/user/Downloads/memtracker_metrics.json \
     && cat >/home/chronos/memtracker.py \
     && python3 -u /home/chronos/memtracker.py $*" \
    < "${SCRIPT_PATH}/memtracker.py"
