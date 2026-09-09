set -gx PATH $HOME/code/github.com/scalacenter/scalac-profiling/external/FlameGraph $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/code/github.com/async-profiler/async-profiler/build/bin $PATH
set -gx PATH $PATH $HOME/.krew/bin
set -gx PATH $PATH /opt/mssql-tools18/bin
set -gx PATH $PATH /opt/nvim-linux-x86_64/bin
set -gx PATH $PATH $HOME/.local/share/coursier/bin
set -gx LD_LIBRARY_PATH $HOME/code/github.com/async-profiler/async-profiler/build/lib $LD_LIBRARY_PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
    bind \cg gcd
end
