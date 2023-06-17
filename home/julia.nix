{ config, pkgs, libs, ...}:
{

  home.packages = with pkgs; [
    julia-bin
  ];

  home.file.".julia/config/startup.jl".text = ''
    import Pkg

    let
        pkgs = ["LanguageServer", "OhMyREPL", "Revise"]
        for pkg in pkgs
          Base.find_package(pkg) === nothing && Pkg.add(pkg)
        end
    end

    using Revise

    if isfile("Project.toml") && isfile("Manifest.toml")
        Pkg.activate(".")
    end

    atreplinit() do repl
        @eval begin
          using OhMyREPL
          OhMyREPL.enable_autocomplete_brackets(false)
          colorscheme!("BoxyMonokai256")
          Base.active_repl.options.auto_indent = false
        end
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

  home.shellAliases = {
    "pluto" = "julia -e 'using Pluto; Pluto.run()'";
  };

}
