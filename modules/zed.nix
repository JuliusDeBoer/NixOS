{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ zed-editor ];

  home-manager.users.julius =
    { ... }:
    {
      xdg.configFile."zed/settings.json".text = builtins.toJSON {
        assistant = {
          default_model = {
            provider = "copilot_chat";
            model = "claude-3-5-sonnet";
          };
          version = "2";
        };

        theme = "Oxocarbon Dark (IBM Carbon)";
        show_edit_predictions = false;

        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        ui_font_size = 16;
        buffer_font_size = 16;
        vim_mode = true;
        auto_update = false;
        ensure_final_newline_on_save = false;
        vim.use_system_clipboard = "never";
        relative_line_numbers = true;
        project_panel.dock = "right";

        buffer_font_family = "Iosevka Term";
        terminal.ui_font_family = "Iosevka Term";

        wrap_guides = [ 80 ];

        lsp.rust-analyzer.binary.path = "/run/current-system/sw/bin/rust-analyzer";
      };
    };
}
