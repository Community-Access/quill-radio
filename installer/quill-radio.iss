; Quill Radio installer -- ships the PyInstaller one-file build.
; Compile with:  ISCC quill-radio.iss [/DFfmpegDir=<dir with ffmpeg.exe>]
; Prerequisite:  ..\dist\QuillRadio.exe  (scripts\build_exe.ps1)
;
; Everything the app needs is bundled -- no on-demand component downloads.
; FfmpegDir supplies ffmpeg.exe/ffprobe.exe (recording, loudness/trim); they
; install to {app}\tools\ffmpeg, which the app finds via QUILL_APP_ROOT.

#define AppName "Quill Radio"
#define AppVersion "1.0.0"
#define AppPublisher "Community Access"
#define AppURL "https://github.com/Community-Access/quill-radio"
#define AppExeName "QuillRadio.exe"

[Setup]
AppId={{35DAB52F-94BB-475C-BA97-A5059C85B3D1}}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
VersionInfoVersion=1.0.0.0
VersionInfoCompany={#AppPublisher}
VersionInfoDescription={#AppName} accessible internet radio
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableDirPage=no
DisableProgramGroupPage=auto
AllowNoIcons=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
OutputBaseFilename=Quill-Radio-Setup-{#AppVersion}
Compression=lzma2/ultra
SolidCompression=yes
WizardStyle=modern
CloseApplications=force
RestartApplications=no
UninstallDisplayName={#AppName} {#AppVersion}
UninstallDisplayIcon={app}\{#AppExeName}
SetupIconFile=..\assets\quill-radio.ico
LicenseFile=..\LICENSE
SetupLogging=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "..\dist\{#AppExeName}"; DestDir: "{app}"; Flags: ignoreversion
#ifdef FfmpegDir
Source: "{#FfmpegDir}\ffmpeg.exe"; DestDir: "{app}\tools\ffmpeg"; Flags: ignoreversion
Source: "{#FfmpegDir}\ffprobe.exe"; DestDir: "{app}\tools\ffmpeg"; Flags: ignoreversion skipifsourcedoesntexist
#endif
Source: "..\docs\userguide.md"; DestDir: "{app}\docs"; Flags: ignoreversion
Source: "..\docs\release-notes-1.0.md"; DestDir: "{app}\docs"; Flags: ignoreversion
Source: "..\README.md"; DestDir: "{app}"; DestName: "README-Quill-Radio.md"; Flags: ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; WorkingDir: "{app}"
Name: "{group}\{#AppName} User Guide"; Filename: "{app}\docs\userguide.md"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; WorkingDir: "{app}"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Run]
Filename: "{app}\{#AppExeName}"; Description: "Launch {#AppName}"; Flags: postinstall nowait skipifsilent unchecked

; Deliberately NO data-wipe prompt on uninstall: Quill Radio shares its
; settings, favorites, and recordings store (%APPDATA%\Quill) with QUILL
; and QUILL Cast. Removing this app must never destroy data a sibling app
; still uses; the full QUILL uninstaller owns that decision.
