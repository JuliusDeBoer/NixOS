{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zed-editor
    television
  ];

  home-manager.users.julius =
    { ... }:
    {
      programs.zed-editor = {
        enable = true;

        extensions = [
          "discord-presence"
        ];

        userSettings = {
          vim_mode = true;
          auto_update = false;

          ensure_final_newline_on_save = true;

          project_panel.dock = "right";

          vim.use_system_clipboard = "never";
          relative_line_numbers = true;
          show_edit_predictions = false;

          telemetry = {
            diagnostics = false;
            metrics = false;
          };

          wrap_guides = [ 80 ];

          lsp.rust-analyzer = {
            binary.path = "/run/current-system/sw/bin/rust-analyzer";
            initialization_options.check.command = "clippy";
          };

          diagnostics = {
            include_warnings = true;
            inline.enabled = true;
          };
        };

        userTasks = [
          {
            label = "Television File Finder";
            command = "zeditor \"$(tv files)\"";
            hide = "always";
            allow_concurrent_runs = true;
            use_new_terminal = true;
          }
          {
            label = "Television RipGrep";
            command = "zeditor \"$(tv text)\"";
            hide = "always";
            allow_concurrent_runs = true;
            use_new_terminal = true;
          }
        ];

        userKeymaps = [
          {
            context = "vim_mode == normal && extension == toml";
            bindings."\\ w" = [
              "workspace::SendKeystrokes"
              "0 f \" i { space version space = space escape $ a , space features space = space [ ] space } escape F ] i"
            ];
          }
          {
            bindings = {
              "ctrl-p" = [
                "task::Spawn"
                {
                  task_name = "Television File Finder";
                  reveal_target = "center";
                }
              ];
              "ctrl-shift-p" = [
                "task::Spawn"
                {
                  task_name = "Television RipGrep";
                  reveal_target = "center";
                }
              ];
            };
          }
        ];
      };
    };
}
