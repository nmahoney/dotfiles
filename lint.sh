#! bin/bash

find bin ! -name .DS_Store -type f -exec shellcheck {} \;
