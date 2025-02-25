{ pkgs, config, ... }:
{
  packages = with pkgs; [ nil ];

  # languages.php.enable = true;
  # languages.php.version = "8.4";

  tasks = {
      "mytask:hello" = {
        exec = ''
          echo "Hello!"
        '';
    };
  };

  enterShell = '''';
}
