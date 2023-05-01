{ config, pkgs, libs, ...}:
{

  home.file.".julia/config/startup.jl".text = ''
    import Pkg

    let
        pkgs = ["Revise", "OhMyREPL"]
        for pkg in pkgs
          if Base.find_package(pkg) === nothing
              Pkg.add(pkg)
          end
        end
    end

    using Revise

    using OhMyREPL
    OhMyREPL.enable_autocomplete_brackets(false)
    colorscheme!("BoxyMonokai256")

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
