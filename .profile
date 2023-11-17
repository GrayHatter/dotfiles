export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim

PATH+=":/home/grayhatter/.gem/ruby/3.0.0/bin"
PATH+=":/home/grayhatter/.cabal/bin"
PATH+=":/home/grayhatter/.bin"
PATH+=":/home/grayhatter/go/bin"

export ESPIDF=/opt/esp-idf
export GOPATH=~/go/
export MAKEFLAGS=" -j 48 "
export CC=clang
export CXX=clang++

export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer
export ASAN_OPTIONS=symbolize=1
export CTEST_OUTPUT_ON_FAILURE=1
export LESS="-RiF --mouse --wheel-lines=4"
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_DEFAULT_COMMAND="fd -H . $HOME"

alias lighton='ssh 192.168.1.204 "echo 9 | sudo tee /sys/class/gpio/gpio{5,6,13}/value"'
alias lightoff='ssh 192.168.1.204 "echo 0 | sudo tee /sys/class/gpio/gpio{5,6}/value"'

alias feh=feh -Fd

alias vi=nvim
alias vim=nvim

