#!/usr/bin/env bash
# Encoding: utf-8
# IBM WebSphere Application Server Liberty Buildpack
# Copyright IBM Corp. 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Kill script for use as the parameter of IBM JDK's filter=java/lang/OutOfMemoryError for -Xdump tool

set -e

echo "
Process Status (Before)
=======================
$(ps -ef)

ulimit (Before)
===============
$(ulimit -a)

Free Disk Space (Before)
========================
$(df -h)
"

# don't kill the process if the user has indicated they want to collect dumps
if echo $JVM_ARGS $JAVA_OPTS | grep -v -q "\-Xdump"; then
  pkill -9 -f .*OutOfMemoryError.*,exec=.*killjava.*
fi

echo "
Process Status (After)
======================
$(ps -ef)

ulimit (After)
==============
$(ulimit -a)

Free Disk Space (After)
=======================
$(df -h)
"
