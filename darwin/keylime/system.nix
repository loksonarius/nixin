{ config, pkgs, lib, ... }: {
  system.defaults.NSGlobalDomain = {
    # 2-finger swipe for forward and back
    AppleEnableSwipeNavigateWithScrolls = true;
    # use 24-hour time for clock
    AppleICUForce24HourTime = true;
    # enable auto-switching between light and dark theme
    AppleInterfaceStyleSwitchesAutomatically = true;
    # disable press and hold behavior for trackpad
    ApplePressAndHoldEnabled = false;
    # jump to spot when clicking on scroll bar
    AppleScrollerPagingBehavior = true;
    # show file extensions in Finder
    AppleShowAllExtensions = true;
    # show hidden files in Finder
    AppleShowAllFiles = true;
    # show scroll bar automatically
    AppleShowScrollBars = "Automatic";
    # show temperature in Celsius -- bite me
    AppleTemperatureUnit = "Celsius";
    # delay before held key is repeated
    InitialKeyRepeat = 25;
    # repeat rate for held key
    KeyRepeat = 2;
    # expand save panel by default, why 2, why not?
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    # set medium size for sidebar icons
    NSTableViewDefaultSizeMode = 2;
    # enable tap to click
    "com.apple.mouse.tapBehavior" = 1;
    # disable "natural" scrolling
    "com.apple.swipescrolldirection" = false;
    # enable secondary clicking on trackpad
    "com.apple.trackpad.enableSecondaryClick" = true;
    # disable force clicking on trackpad
    "com.apple.trackpad.forceClick" = false;
    # maximize trackpad track speed
    "com.apple.trackpad.scaling" = 2.5;
  };

  system.defaults.WindowManager = {
    # disable wallpaper click to show desktop
    EnableStandardClickToShowDesktop = false;
    # hide desktop items
    StandardHideDesktopIcons = true;
    # hide desktop widgets
    StandardHideWidgets = true;
  };

  system.defaults.dock = {
    # display app switcher on all displays
    appswitcher-all-displays = true;
    # always show the dock
    autohide = false;
    # disable dock magnification on hover 
    magnification = false;
    # disable MRU switching for spaces -- ew!
    mru-spaces = false;
    # position dock on screen bottom
    orientation = "bottom";
    # persistent apps on dock
    persistent-apps = [
      "/Applications/Safari.app"
      "/System/Applications/Music.app"
      "/System/Applications/Mail.app"
      "/Applications/Discord.app"
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
    ];
    # persistent folders on dock
    persistent-others = [ "/Users/danh/Downloads" ];
    # display process indicators on dock
    show-process-indicators = true;
    # hide recent and suggested applications on dock
    show-recents = false;
    # set dock icon size
    tilesize = 44;
    # activate Mission Control on bottom right corner hover
    wvous-br-corner = 2;
  };

  system.defaults.finder = {
    # show file extensions in Finder
    AppleShowAllExtensions = true;
    # show hidden files in Finder
    AppleShowAllFiles = true;
    # hide all Desktop icons
    CreateDesktop = false;
    # suppress extension change warning
    FXEnableExtensionChangeWarning = false;
    # set default finder display style to columns
    FXPreferredViewStyle = "clmv";
    # show path breadcrumbs in windows
    ShowPathbar = true;
  };

  # disable guest account on login
  system.defaults.loginwindow.GuestEnabled = false;

  system.defaults.menuExtraClock = {
    # show menu bar time in 24-hour format
    Show24Hour = true;
    # always show full date in menu bar clock
    ShowDate = 1;
    # show month day in menu bar clock
    ShowDayOfMonth = true;
    # show weekday in menu bar clock
    ShowDayOfWeek = true;
  };

  system.defaults.screencapture = {
    location = "~/Desktop";
    type = "png";
  };

  system.defaults.trackpad = {
    # enable tap to click
    Clicking = true;
    # disable tap to drag
    Dragging = false;
    # minimize force required to activate click
    FirstClickThreshold = 1;
    # enable trackpad right clicking
    TrackpadRightClick = true;
    # disable three-finger-tap data detector
    TrackpadThreeFingerTapGesture = 0;
  };

  system.defaults.CustomUserPreferences = {
    "NSGlobalDomain" = {
      # set accent color to green
      AppleAccentColor = 3;
      # set highlight color to green
      "AppleHighlightColor" = "0.752941 0.964706 0.678431 Green";
    };
    "com.apple.finder" = {
      # search current folder by default on Finder
      FXDefaultSearchScope = "SCcf";
    };
    "com.apple.desktopservices" = {
      # avoid creating .DS_Store files on network volumes
      DSDontWriteNetworkStores = true;
      # avoid creating .DS_Store files on USB volumes
      DSDontWriteUSBStores = true;
    };
    "com.apple.AdLib" = {
      # disable personalied ads
      allowApplePersonalizedAdvertising = false;
    };
    "com.apple.SoftwareUpdate" = {
      # enable update auto checking
      AutomaticCheckEnabled = true;
      # check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # download newly available updates in background
      AutomaticDownload = 1;
      # install System data files and security updates
      CriticalUpdateInstall = 1;
    };
  };
}
