{ config, pkgs, libs, ...}:
{

  home.file.".julia/config/startup.jl".text = ''
    using Pkg

    # automatically reload code of imported libraries
    # https://timholy.github.io/Revise.jl/stable/config
    try
        using Revise
    catch e
        @warn "Error initializing Revise" exception=(e, catch_backtrace())
    end


    # syntax highlighting and other enhancements for the Julia REPL
    # https://github.com/KristofferC/OhMyREPL.jl
    atreplinit() do repl
        try
            @eval using OhMyREPL
            @async begin
                # deactivate bracket completion for vim-slime to work
                OhMyREPL.enable_autocomplete_brackets(false)
            end
        catch e
            @warn(e.msg)
        end
    end

    # automatically activate the environment
    # if the current folder is a project folder
    if isfile("Project.toml") && isfile("Manifest.toml")
        Pkg.activate(".")
    end
  '';

  home.file.".julia/config/startup_ijulia.jl".text = ''
    # automatically reload code of imported libraries
    # https://timholy.github.io/Revise.jl/stable/config
    try
        @eval using Revise
    catch e
        @warn "Error initializing Revise" exception=(e, catch_backtrace())
    end
  '';

}
