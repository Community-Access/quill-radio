; Quill Radio installer.
; Compile with:  ISCC quill-radio.iss /DPayloadDir=..\payload
; PayloadDir is a QUILL Windows portable bundle (embedded Python runtime
; flattened at the root plus Lib\site-packages\quill), produced by the main
; repo's scripts/build_windows_distribution.py. See scripts/build_installer.ps1.

#ifndef PayloadDir
  #define PayloadDir "..\payload"
#endif

#define AppName "Quill Radio"
#define AppVersion "1.0.0"
#define AppPublisher "Community Access"
#define AppURL "https://github.com/Community-Access/quill-radio"
#define AppExeName "quill.exe"

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
LicenseFile=..\LICENSE
SetupLogging=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Only what Quill Radio needs ships. Everything the full QUILL installer
; already fetches on demand stays on demand, and the components Radio never
; touches -- transcription (whisper.cpp / Faster Whisper / Vosk), neural TTS
; voices (Kokoro / Piper), braille, Pandoc, DECtalk, eSpeak-NG, Node.js,
; offline wheels, the PRD -- are excluded from the payload copy outright.
; What remains: the embedded Python runtime, the quill package and its
; site-packages, and this app's own docs.

[InstallDelete]
; Upgrade hygiene, same rationale as the QUILL installer: wipe our own
; package tree before [Files] re-lays it so renamed/removed modules never
; linger and cause version-skew import errors.
Type: filesandordirs; Name: "{app}\Lib\site-packages\quill"
Type: filesandordirs; Name: "{app}\__pycache__"

[Files]
Source: "{#PayloadDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "docs\*,*\__pycache__\*,tools\*,vendor\*,wheels\*,kokoro-models\*,speech-models-bundled\*,_tool-download\*,_speech-download\*"
Source: "..\docs\userguide.md"; DestDir: "{app}\docs"; Flags: ignoreversion
Source: "..\docs\release-notes-1.0.md"; DestDir: "{app}\docs"; Flags: ignoreversion
Source: "..\README.md"; DestDir: "{app}"; DestName: "README-Quill-Radio.md"; Flags: ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: "-m quill.apps.radio"; WorkingDir: "{app}"
Name: "{group}\{#AppName} User Guide"; Filename: "{app}\docs\userguide.md"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: "-m quill.apps.radio"; WorkingDir: "{app}"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Run]
Filename: "{app}\{#AppExeName}"; Parameters: "-m quill.apps.radio"; Description: "Launch {#AppName}"; Flags: postinstall nowait skipifsilent unchecked

[UninstallDelete]
Type: filesandordirs; Name: "{app}\__pycache__"
Type: filesandordirs; Name: "{app}\Lib"

; Deliberately NO data-wipe prompt on uninstall: Quill Radio shares its
; settings, favorites, and recordings store (%APPDATA%\Quill) with QUILL
; and QUILL Cast. Removing this app must never destroy data a sibling app
; still uses; the full QUILL uninstaller owns that decision.
