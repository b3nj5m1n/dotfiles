{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      android-studio
      kotlin
      kotlin-language-server
    ];
    programs.adb.enable = true;
    users.users."b3nj4m1n".extraGroups = ["adbusers"];
  };
}
