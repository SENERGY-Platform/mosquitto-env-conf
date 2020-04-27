#!/bin/ash


#Copyright 2020 Yann Dumont

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.



set -e

CONFIG=/mosquitto/config/mosquitto.conf

touch $CONFIG

for env_var in $(env); do
    if [ -n "$(echo $env_var | grep -E '^EM_')" ]; then
        name=$(echo "$env_var" | sed -r "s/EM_([^=]*)=.*/\1/g" | tr '[:upper:]' '[:lower:]')
        env_var_name=$(echo "$env_var" | sed -r "s/([^=]*)=.*/\1/g")
        value=$(printenv $env_var_name)
        echo "$name=$value" >> $CONFIG
    fi
done

exec "$@"
